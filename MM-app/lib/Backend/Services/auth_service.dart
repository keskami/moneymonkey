// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/home.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StudentProfileService _profileService = StudentProfileService();


  /// Checks if an email is already in use
  Future<bool> checkEmailUsed(String email, BuildContext context) async {
    if (!Get.isRegistered<SignUpController>()) {
      _showSnackBar(context, "Internal error: SignUp flow not initialized.", Colors.red);
      return false;
    }
    final SignUpController signUpController = Get.find<SignUpController>();
    signUpController.isLoading.value = true;
    
    if (!email.isEmail) {
      _showSnackBar(context, "Enter a valid email.", Colors.red);
      signUpController.isLoading.value = false;
      return false;
    }

    try {
      // Use the new collection name and field structure
      final emailSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (emailSnapshot.docs.isNotEmpty) {
        _showSnackBar(context, "Email already associated with a user.", Colors.red);
        signUpController.isLoading.value = false;
        return false;
      }

      signUpController.isLoading.value = false;
      return true;
    } catch (e) {
      _showSnackBar(context, "Error checking email: $e", Colors.red);
      signUpController.isLoading.value = false;
      return false;
    }
  }

  /// Signs up a new user with email and password
  Future<bool> signUpUser(BuildContext context) async {
    // Ensure required controllers are registered before attempting signup
    if (!Get.isRegistered<SignUpController>() ||
        !Get.isRegistered<StartFreshController>() ||
        !Get.isRegistered<GettingStartedController>()) {
      _showSnackBar(context, "Internal error: Sign up controllers not available.", Colors.red);
      return false;
    }
    final SignUpController signUpController = Get.find<SignUpController>();
    final StartFreshController startFreshController = Get.find<StartFreshController>();
    final GettingStartedController gettingStartedController = Get.find<GettingStartedController>();
    try {
      signUpController.isLoading.value = true;
      
      String email = signUpController.email.value.trim();
      String password = signUpController.password.value;

      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      // Create comprehensive student profile using the new model
      final student = _createStudentProfile(
        userId: userId,
        email: email,
        fullName: signUpController.name.value,
        username: signUpController.username.value,
        phoneNumber: signUpController.phoneNumber.value,
        age: gettingStartedController.age.value,
        knowledgeLevel: gettingStartedController.knowledgeLevel.value,
        learningGoal: startFreshController.learningGoal.value,
      );

      // Save using the profile service (includes caching)
      await _profileService.updateProfileOptimistic(userId, student);

      // Create additional user data collections
      await _createSampleTransactions(userId);
      await _createProgressionCollection(userId);

      signUpController.isLoading.value = false;
      _navigateToHome(context);
      return true;
    } catch (e) {
      signUpController.isLoading.value = false;
      _handleAuthError(e, context, "Error during sign up");
      return false;
    }
  }

  /// Signs in an existing user with email and password
  Future<bool> signInUser(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // Preload user profile into cache for better performance
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        try {
          await _profileService.loadProfileWithCache(userId);
        } catch (e) {
          // Profile loading error shouldn't prevent sign in
          debugPrint('Failed to preload profile: $e');
        }
      }
      
      _navigateToHome(context);
      return true;
    } catch (e) {
      _handleAuthError(e, context, "Error signing in");
      return false;
    }
  }

  /// Handles Google authentication for both sign up and sign in (WEB VERSION)
  Future<bool> googleAuth(BuildContext context) async {
    try {
      // For web, use GoogleAuthProvider directly with Firebase Auth
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      
      // Add scopes if needed
      googleProvider.addScope('email');
      googleProvider.addScope('profile');
      
      // Sign in with popup for web
      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      
      String userId = userCredential.user?.uid ?? '';
      String email = userCredential.user?.email ?? '';
      String? displayName = userCredential.user?.displayName;

      if (email.isEmpty) {
        _showSnackBar(context, "Unable to get email from Google account.", Colors.red);
        return false;
      }

      // Check if user profile exists using the profile service
      try {
        await _profileService.loadProfileWithCache(userId);
        // Profile exists, user is signed in
      } catch (e) {
        // Profile doesn't exist, create new student profile
        final student = _createStudentProfile(
          userId: userId,
          email: email,
          fullName: displayName ?? 'User',
          username: displayName ?? 'User',
        );

        await _profileService.updateProfileOptimistic(userId, student);
        
        // Create additional collections for new Google user
        await _createSampleTransactions(userId);
        await _createProgressionCollection(userId);
      }

      _navigateToHome(context);
      return true;
    } catch (e) {
      _handleAuthError(e, context, "Error during Google Sign In");
      return false;
    }
  }

  /// Signs out the current user and clears cache
  Future<bool> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      
      // Clear all cached profile data on sign out
      await _profileService.clearAllCache();
      
      return true;
    } catch (e) {
      _showSnackBar(context, "Error during sign out: $e", Colors.red);
      return false;
    }
  }

  /// Creates a Student profile object with all required data
  Student _createStudentProfile({
    required String userId,
    required String email,
    String fullName = 'Your Name Here',
    String username = 'Your Name Here',
    String phoneNumber = '',
    int age = 0,
    int knowledgeLevel = 0,
    int learningGoal = 0,
  }) {
    // Create default followers and following (consider removing in production)
    Map<String, bool> defaultClassrooms = {
      'tempClassId1_2025': true,
      'tempClassId2_2025': true,
    };

    // Create profile data
    final profileData = ProfileData(
      fullName: fullName,
      username: username,
      numberOfFollowers: 3, // Based on your original followers list
      following: 2, // Based on your original following list
      topAchievements: 0,
      streak: 0,
      totalProfit: 0.0,
      portfolioScore: 0.0,
      averageMonthlyGrowth: 0.0,
    );

    // Create settings with all nested structures
    final announcementNotifications = AnnouncementNotifications(
      educationalTipsEmail: true,
      educationalTipsPhone: false,
      marketingNotificationsEmail: true,
      marketingNotificationsPhone: false,
    );

    final friendNotifications = FriendNotifications(
      friendActivityEmail: true,
      friendActivityPhone: false,
      newFollowerEmail: true,
      newFollowerPhone: false,
    );

    final reminderNotifications = ReminderNotifications(
      practiceEmail: true,
      practicePhone: false,
      reminderTime: '08:00 AM',
      weeklyProgress: false,
    );

    final notificationSettings = NotificationSettings(
      announcements: announcementNotifications,
      friends: friendNotifications,
      reminders: reminderNotifications,
    );

    final userPreferences = UserPreferences(
      audio: false,
      darkMode: false,
      soundEffects: true,
    );

    final privacySettings = PrivacySettings(
      publicProfile: true,
    );

    final settingsData = SettingsData(
      notifications: notificationSettings,
      preferences: userPreferences,
      privacySettings: privacySettings,
    );

    // Create the complete student profile
    return Student(
      userId: userId,
      email: email,
      name: fullName,
      role: 'student',
      createdAt: DateTime.now(),
      isActive: true,
      age: age,
      classrooms: defaultClassrooms,
      knowledgeLevel: knowledgeLevel,
      learningGoalPerDay: learningGoal,
      phoneNumber: phoneNumber,
      startingLevel: 1,
      progress: 'A.1.1.1',
      profile: profileData,
      settings: settingsData,
    );
  }

  /// Creates sample transactions for new users
  Future<void> _createSampleTransactions(String userId) async {
    final transactionsRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('Transactions');

    final sampleTransactions = [
      {
        'Source/Destination': 'Test Source',
        'Amount': 200,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
      {
        'Source/Destination': 'Test Source 2',
        'Amount': 150,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
      {
        'Source/Destination': 'Test Expense Source 1',
        'Amount': -100,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Expense"
      },
      {
        'Source/Destination': 'Test Expense Source 2',
        'Amount': -50,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Expense"
      },
      {
        'Source/Destination': 'Test Source 3',
        'Amount': 300,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
    ];

    for (var transaction in sampleTransactions) {
      await transactionsRef.add(transaction);
    }
  }

  /// Creates initial progression data for new users
  Future<void> _createProgressionCollection(String userId) async {
    final progressionCollectionRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('Progression');
    
    await progressionCollectionRef.doc('progression1').set({
      'Level': 1,
      'Unit': 1,
      'Lesson': 'Earning and Saving',
      'Progress': 0,
      'Quiz Scores': [],
      'Earnings from Lesson': {
        'Monkeys': 0,
        'Diamonds': 0,
        'Bananas': 0,
      },
    });
  }

  /// Gets the current user's profile from cache or Firebase
  Future<Student?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      return await _profileService.loadProfileWithCache(user.uid);
    } catch (e) {
      debugPrint('Error loading current user profile: $e');
      return null;
    }
  }

  /// Checks if user is signed in and has a valid profile
  Future<bool> isUserSignedIn() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      // loadProfileOfflineFirst throws if profile not found; success means user has profile
      await _profileService.loadProfileOfflineFirst(user.uid);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Updates the current user's profile
  Future<bool> updateCurrentUserProfile(Student updatedProfile) async {
    try {
      await _profileService.updateProfileOptimistic(updatedProfile.userId, updatedProfile);
      return true;
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      return false;
    }
  }

  /// Navigates to the home page
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  /// Shows a snackbar message
  void _showSnackBar(BuildContext context, String message, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Handles authentication errors
  void _handleAuthError(dynamic error, BuildContext context, String defaultMessage) {
    String message = defaultMessage;
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;
        case 'network-request-failed':
          message = 'Network error. Please check your connection.';
          break;
        default:
          message = error.message ?? defaultMessage;
      }
    }

    _showSnackBar(context, message, Colors.red);
  }

  // Stream for listening to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Get current user
  User? get currentUser => _auth.currentUser;
  
  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;
}