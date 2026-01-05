import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Loading%20Widgets/shimmer_loading_container.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/LessonPages/Controllers/Lesson_Refresh.dart';
import 'package:money_monkey/Profile/Widgets/add_friends_button.dart';
import 'package:money_monkey/Profile/Widgets/share_button.dart';
import 'package:money_monkey/Settings/Pages/settings.dart';
import 'package:money_monkey/themes/color_themes.dart';
import 'package:money_monkey/LoginPages/login.dart'; // Add this import

import '../Friends/friendsHome.dart';
import 'Widgets/custom_stat.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  Student? userData;
  bool isLoading = true;
  final StudentProfileService profileService = StudentProfileService();
  Worker? _refreshWorker;
  
  // Real-time listener subscription
  StreamSubscription<Student>? _profileSubscription;

  void _setupRealtimeListener() async {
    if (userID == null) return;
    
    try {
      // Load from cache first for instant display
      userData = await profileService.loadProfileOfflineFirst(userID!);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      
      // Then setup real-time listener for updates
      _profileSubscription = profileService
          .getProfileRealTimeWithCache(userID!)
          .listen(
            (profile) {
              if (mounted) {
                setState(() {
                  userData = profile;
                  isLoading = false;
                });
              }
            },
            onError: (error) {
              debugPrint('❌ Real-time listener error: $error');
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
          );
    } catch (e) {
      debugPrint('❌ Error setting up listener: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Logout function
  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Sign Out',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: GoogleFonts.inter(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Close dialog
                  
                  try {
                    // Clear cache before signing out
                    await profileService.clearAllCache();
                    
                    // Sign out from Firebase
                    await FirebaseAuth.instance.signOut();
                    
                    // Navigate to login screen and clear navigation stack
                    if (mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  } catch (e) {
                    debugPrint("Error during logout: $e");
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error signing out. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Sign Out',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setupRealtimeListener();
    
    // Keep existing refresh worker for compatibility
    if (Get.isRegistered<LessonRefreshController>()) {
      _refreshWorker = ever(Get.find<LessonRefreshController>().shouldRefresh, (_) {
        if (mounted) {
          debugPrint('🔄 Manual refresh triggered - real-time listener handles updates automatically');
          // Real-time listener handles updates automatically
        }
      });
    }
  }

  @override
  void dispose() {
    _profileSubscription?.cancel();
    _refreshWorker?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            height: screenHeight * 0.2,
            width: screenHeight * 0.2,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return screenWidth > screenHeight
        ? modernDesktopDisplay(context, screenHeight, screenWidth)
        : mobileDisplay(context, screenHeight, screenWidth);
  }

  Widget modernDesktopDisplay(BuildContext context, double screenHeight, double screenWidth) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: userData == null
          ? const Center(child: Text("Error loading user data"))
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
                  ),
                ),
                child: Column(
                  children: [
                    // Header Section with Glass Effect
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            LightTheme().primaryBlue.withOpacity(0.1),
                            LightTheme().primaryGreen.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Settings and Logout Buttons Row
                          Positioned(
                            top: 40,
                            right: 40,
                            child: Row(
                              children: [
                                // Logout Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.red.shade200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () => _logout(context),
                                    icon: Icon(
                                      Icons.logout,
                                      size: 24,
                                      color: Colors.red.shade600,
                                    ),
                                    tooltip: 'Sign Out',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Settings Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const ProfileSettingsPage(),
                                      ));
                                    },
                                    icon: Icon(
                                      Icons.settings,
                                      size: 28,
                                      color: LightTheme().primaryBlue,
                                    ),
                                    tooltip: 'Settings',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Profile Content
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Profile Picture with Glow Effect
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: LightTheme().primaryBlue.withOpacity(0.3),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Container(
                                      height: 180,
                                      width: 180,
                                      padding: const EdgeInsets.all(8), // Add padding inside circle
                                      child: ClipOval(
                                        child: Transform.translate(
                                          offset: const Offset(0, -4), // Move image up slightly
                                          child: Image.network(
                                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FNoProfilePicture.png?alt=media&token=454be09c-518a-42d5-bee7-e64e4cc44376",
                                            height: 164, // Slightly smaller than container
                                            width: 164,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return ShimmerContainer(height: 164, width: 164);
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return ShimmerContainer(height: 164, width: 164);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Name and Username
                                Container(
                                  width: screenWidth * 0.6, // Constrain width
                                  child: Text(
                                    userData!.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2, // Allow up to 2 lines
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: userData!.name.length > 20 ? 28 : 36, // Smaller font for long names
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "@${userData!.profile.username}",
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: const Color(0xFF64748B),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Real-time connection indicator
                                    Tooltip(
                                      message: _profileSubscription != null ? 'Live updates active' : 'Offline mode',
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: _profileSubscription != null 
                                              ? Colors.green.withOpacity(0.1)
                                              : Colors.grey.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: _profileSubscription != null 
                                              ? Colors.green 
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Experience Level Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        LightTheme().primaryBlue,
                                        LightTheme().primaryGreen,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    userData!.experienceLevel,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Main Content Area
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column - Stats and Actions
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Action Buttons Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildActionButton(
                                        "Add Friends",
                                        Icons.person_add,
                                        LightTheme().primaryBlue,
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => FriendsHome()),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildActionButton(
                                        "Share Profile",
                                        Icons.share,
                                        LightTheme().primaryGreen,
                                        () {
                                          // Share functionality
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                
                                // Performance Stats Section
                                Text(
                                  "Performance Overview",
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                
                                // Stats Grid
                                _buildStatsGrid(),
                                
                                const SizedBox(height: 40),
                                
                                // Level Up Section
                                if (userData!.canLevelUp) _buildLevelUpCard(),
                              ],
                            ),
                          ),
                          
                          const SizedBox(width: 40),
                          
                          // Right Column - Social Stats & Achievements
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Social Stats Card
                                _buildSocialStatsCard(),
                                const SizedBox(height: 32),
                                
                                // Achievements Section
                                _buildAchievementsSection(),
                                const SizedBox(height: 32),
                                
                                // Progress Card
                                _buildProgressCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          "Day Streak",
          userData!.profile.streak.toString(),
          Icons.local_fire_department,
          Colors.orange,
          "${userData!.profile.hasLongStreak ? 'Great' : 'Good'} momentum!",
        ),
        _buildStatCard(
          "Portfolio Score",
          "${userData!.profile.portfolioScore.toInt()}/100",
          Icons.trending_up,
          LightTheme().primaryGreen,
          userData!.profile.performanceLevel,
        ),
        _buildStatCard(
          "Total Profit",
          "\$${userData!.profile.totalProfit.toInt()}",
          Icons.attach_money,
          Colors.green,
          userData!.profile.totalProfit > 0 ? "Profitable" : "Learning",
        ),
        _buildStatCard(
          "Monthly Growth",
          "${userData!.profile.averageMonthlyGrowth}%",
          Icons.show_chart,
          LightTheme().primaryBlue,
          "Average growth",
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialStatsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Social Stats",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      userData!.profile.numberOfFollowers.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: LightTheme().primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Followers",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: const Color(0xFFE2E8F0),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      userData!.profile.following.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: LightTheme().primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Following",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (userData!.profile.isInfluencer) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Influencer",
                style: GoogleFonts.inter(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Achievements",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: GoogleFonts.inter(
                    color: LightTheme().primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_1.png?alt=media&token=976c4a31-8935-4577-8371-ecc87513e2c5"),
              _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_2.png?alt=media&token=5949c906-f8db-401c-902e-e3fc9d46ec7d"),
              _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_3.png?alt=media&token=5541600c-da47-4c45-b5e0-aab024bb8076"),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "${userData!.profile.topAchievements} achievements unlocked",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementIcon(String url) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return ShimmerContainer(height: 50, width: 50);
          },
          errorBuilder: (context, error, stackTrace) {
            return ShimmerContainer(height: 50, width: 50);
          },
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Learning Progress",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Current Level",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Level ${userData!.knowledgeLevel}",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: LightTheme().primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Progress: ${userData!.progress}",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: userData!.dailyGoalProgress / 100,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(LightTheme().primaryGreen),
          ),
          const SizedBox(height: 8),
          Text(
            "Daily Goal: ${userData!.dailyGoalProgress.toInt()}%",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelUpCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LightTheme().primaryBlue,
            LightTheme().primaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: LightTheme().primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ready to Level Up!",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You've met the requirements to advance to the next level.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  // Mobile display with logout button
  Widget mobileDisplay(BuildContext context, double screenHeight, double screenWidth) {
    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: userData == null
          ? const Center(child: Text("Error loading user data"))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with logout button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logout Button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: IconButton(
                              onPressed: () => _logout(context),
                              icon: Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.red.shade600,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Profile",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Real-time connection indicator
                              Tooltip(
                                message: _profileSubscription != null ? 'Live' : 'Offline',
                                child: Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: _profileSubscription != null 
                                      ? Colors.green 
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // Settings Button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ProfileSettingsPage(),
                                ));
                              },
                              icon: Icon(
                                Icons.settings,
                                size: 20,
                                color: LightTheme().primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Profile Picture
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: LightTheme().primaryBlue.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FNoProfilePicture.png?alt=media&token=454be09c-518a-42d5-bee7-e64e4cc44376",
                              height: screenHeight / 4.5,
                              width: screenHeight / 4.5,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return ShimmerContainer(height: screenHeight / 4.5, width: screenHeight / 4.5);
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return ShimmerContainer(height: screenHeight / 4.5, width: screenHeight / 4.5);
                              },
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Name and Username
                      Center(
                        child: Column(
                          children: [
                            Text(
                              userData!.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "@${userData!.profile.username}",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    LightTheme().primaryBlue,
                                    LightTheme().primaryGreen,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                userData!.experienceLevel,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Social Stats Row
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    userData!.profile.numberOfFollowers.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: LightTheme().primaryBlue,
                                    ),
                                  ),
                                  Text(
                                    "Followers",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    userData!.profile.following.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: LightTheme().primaryGreen,
                                    ),
                                  ),
                                  Text(
                                    "Following",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              "Add Friends",
                              Icons.person_add,
                              LightTheme().primaryBlue,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FriendsHome()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionButton(
                              "Share Profile",
                              Icons.share,
                              LightTheme().primaryGreen,
                              () {
                                // Share functionality
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Achievements Section
                      Text(
                        "Achievements",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_1.png?alt=media&token=976c4a31-8935-4577-8371-ecc87513e2c5"),
                            _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_2.png?alt=media&token=5949c906-f8db-401c-902e-e3fc9d46ec7d"),
                            _buildAchievementIcon("https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_3.png?alt=media&token=5541600c-da47-4c45-b5e0-aab024bb8076"),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Stats Section
                      Text(
                        "Performance Stats",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Stats Grid for Mobile
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                        children: [
                          _buildMobileStatCard(
                            "Streak",
                            userData!.profile.streak.toString(),
                            Icons.local_fire_department,
                            Colors.orange,
                          ),
                          _buildMobileStatCard(
                            "Score",
                            "${userData!.profile.portfolioScore.toInt()}/100",
                            Icons.trending_up,
                            LightTheme().primaryGreen,
                          ),
                          _buildMobileStatCard(
                            "Profit",
                            "\${userData!.profile.totalProfit.toInt()}",
                            Icons.attach_money,
                            Colors.green,
                          ),
                          _buildMobileStatCard(
                            "Growth",
                            "${userData!.profile.averageMonthlyGrowth}%",
                            Icons.show_chart,
                            LightTheme().primaryBlue,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 100), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildMobileStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}