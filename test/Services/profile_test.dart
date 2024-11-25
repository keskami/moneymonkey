import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:money_monkey/Backend/Models/settings.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';
import 'package:money_monkey/Backend/Services/firestore_service.dart';
import 'package:money_monkey/Profile/profile_page.dart';

// Mock FirestoreService
class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late MockFirestoreService mockFirestoreService;

  setUp(() {
    mockFirestoreService = MockFirestoreService();
  });

  testWidgets('ProfileScreen shows loading indicator initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileScreen(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('ProfileScreen shows error message when user data is null',
      (WidgetTester tester) async {
    // Mock the FirestoreService to return null
    when(mockFirestoreService.getUserData(captureAny as String))
        .thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Wait for async code to complete
    await tester.pumpAndSettle();

    expect(find.text('Error loading user data'), findsOneWidget);
  });

  testWidgets('ProfileScreen displays user data when available',
      (WidgetTester tester) async {
    // Mock user data
    final mockUserData = UserData(
      userId: '12345',
      email: 'john.doe@example.com',
      phoneNumber: '1234567890',
      age: 30,
      knowledgeLevel: 5,
      learningGoalPerDay: 10,
      startingLevel: 1,
      profile: ProfileData(
        fullName: 'John Doe',
        username: 'johndoe',
        numberOfFollowers: 108,
        following: 42,
        topAchievements: 3,
        streak: 7,
        totalProfit: 500.75,
        portfolioScore: 85.0,
        averageMonthlyGrowth: 12.5,
      ),
      settings: SettingsData(
          preferences:
              Preferences(soundEffects: false, audio: false, darkMode: false),
          notifications: Notifications(
              reminders: RemindersNotifications(),
              friends: FriendsNotifications(),
              announcements: AnnouncementsNotifications()),
          privacySettings: PrivacySettings(publicProfile: false)),
    );

    // Mock the FirestoreService to return mockUserData
    when(mockFirestoreService.getUserData(any as String))
        .thenAnswer((_) async => mockUserData);

    await tester.pumpWidget(
      MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Wait for async code to complete
    await tester.pumpAndSettle();

    // Assertions
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('@johndoe'), findsOneWidget);
    expect(find.text('42'), findsOneWidget); // Following count
    expect(find.text('108'), findsOneWidget); // Followers count
    expect(find.text('Achievements'), findsOneWidget);
    expect(find.text('7'), findsOneWidget); // Streak
    expect(find.text('+500'), findsOneWidget); // Total Profit (rounded)
    expect(find.text('85/100'), findsOneWidget); // Portfolio Score
    expect(find.text('12.5%'), findsOneWidget); // Monthly Growth
  });
}
