# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MoneyMonkey is a Flutter-based financial literacy learning platform with Firebase backend, featuring:
- Interactive lessons with progress tracking
- AI-powered chat assistant (OpenAI integration)
- Budget simulator with real-world scenarios
- Portfolio management and investment tracking
- Social features (friends, profiles, achievements)
- Multi-platform support (iOS, Android, Web)

## Development Commands

### Flutter Commands
```bash
# Run the app
flutter run

# Build for specific platforms
flutter build web
flutter build apk
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze

# Clean build artifacts
flutter clean

# Get dependencies
flutter pub get
```

### Firebase/Node.js Commands
```bash
# Install Firebase tools and dependencies
npm install

# Run Firebase setup script
node firebase_setup.js
```

## Architecture Overview

### State Management
- **GetX**: Primary state management solution used throughout the app
- Controllers are registered with `Get.put()` and accessed with `Get.find()`
- Observable state with `.obs` and `Obx()` widgets for reactive UI
- Key controllers:
  - `HomePagesController`: Main navigation and page routing
  - `ConversationController`: AI chatbot conversations
  - `SignUpController`, `StartFreshController`, `GettingStartedController`: Onboarding flow

### Directory Structure

**lib/Backend/**
- `Services/`: Core business logic and API integrations
  - `auth_service.dart`: Firebase Auth (email/password, Google OAuth)
  - `lesson_progress_service.dart`: Tracks student lesson completion
  - `CacheServices.dart`: Profile and data caching with GetStorage
  - `OpenAIService.dart`: AI assistant integration
  - `AcademicServices.dart`: Lesson and curriculum management
- `Models/`: Data models (e.g., `StudentData.dart`)
- `Controllers/`: State controllers for backend operations

**lib/LessonPages/**
- `Pages/`: Lesson UI screens (`LessonsHome.dart`, `LessonHomeUnit.dart`)
- `SubComponentPages/`: Lesson components (MCQ, celebrations, etc.)
- `Controllers/`: Lesson state management
- `Services/`: Lesson-specific business logic

**lib/GettingStarted/**
- Complete onboarding flow (intro, sign-up, start fresh)
- Multi-step forms with validation
- User profiling (age, knowledge level, learning goals)

**lib/BudgetSimulator/**
- Interactive financial simulation game
- Random events, expenses, milestones tracking
- Standalone feature with own models and services

**lib/GlobalWidgets/**
- Reusable components across the app
- `ChatBotDialog.dart`: AI assistant chat interface
- `SideBar.dart`: Main navigation sidebar

### Firebase Structure

**Collections:**
- `users/{userId}`: User profiles with nested profile and settings data
  - Subcollection `Transactions`: User financial transactions
  - Subcollection `Progression`: Lesson progress tracking
- Flattened data model - profile and settings stored as nested maps in user document

### Authentication Flow

1. App starts → `main.dart` checks `FirebaseAuth.instance.authStateChanges()`
2. Not authenticated → `GettingStartedHome()` (onboarding flow)
3. Authenticated → `HomePage()` (main app)
4. Sign-up creates user in Auth + Firestore profile with sample data
5. Profile caching via `CacheServices.dart` for offline-first experience

### Navigation Pattern

- `HomePage` contains sidebar + `IndexedStack` with all main pages
- Page switching via `HomePagesController.changePage(index)`
- Pages in order: Lessons, Portfolio, Coming Soon, Homework, Budget Simulator, Profile
- Sidebar expands/collapses based on current page (collapsed for pages 3-4)

### Key Integration Points

**AI Assistant (OpenAI):**
- General assistant ID: `asst_Miaq9XzcKdd5B5jM0k3ZRinx`
- Lesson-specific assistants registered per lesson
- Conversation history managed in `ConversationController`
- API keys loaded from `keys.env` file

**Caching Strategy:**
- `GetStorage` for local persistence
- Three loading strategies in `CacheServices.dart`:
  - `loadProfileWithCache()`: Network-first
  - `loadProfileOfflineFirst()`: Cache-first
  - `updateProfileOptimistic()`: Update cache immediately, sync to Firebase

**Progress Tracking:**
- Progress format: `A.1.2.6` = Level A, Unit 1, Lesson 2, Step 6
- Lesson completion tracked in `Progression` subcollection
- Rewards (Monkeys, Diamonds, Bananas) stored per lesson

## Development Patterns

### Adding New Lesson Pages
1. Create widget in `lib/LessonPages/SubComponentPages/`
2. Register in lesson flow controller
3. Update progress tracking in `lesson_progress_service.dart`
4. Add celebration screen integration if needed

### Working with Student Profiles
- Always use `StudentProfileService` from `CacheServices.dart`
- Never directly access Firestore for user profiles
- Profile model in `StudentData.dart` includes validation methods
- Check `student.isValid` before saving

### Adding GetX Controllers
1. Create controller extending `GetxController`
2. Register early in widget lifecycle: `Get.put<MyController>(MyController())`
3. Access with `Get.find<MyController>()`
4. Use `.obs` for reactive state and `update()` or `Obx()` for UI updates

### Error Handling
- Auth errors handled in `auth_service.dart` with user-friendly messages
- Firebase exceptions mapped to readable error strings
- Loading states managed with `.isLoading.obs` in controllers

## Environment Configuration

**Required files:**
- `keys.env`: API keys for OpenAI and other services
- `firebase_options.dart`: Auto-generated by FlutterFire CLI
- Firebase Admin SDK key: `money-monkey-f4d73-firebase-adminsdk-vhr5p-e96e398198.json`

**Firebase config:**
- Project ID: `money-monkey-f4d73`
- Web, iOS, Android apps configured
- Firestore, Auth, Storage enabled

## Lesson Progress Format

Progress string format: `{Level}.{Unit}.{Lesson}.{Step}`
- Example: `A.1.2.6` = Level A, Unit 1, Lesson 2, Step 6
- Starting progress: `A.1.1.1`
- Update via `lesson_progress_service.dart`

## UI/Theme

- Light and dark themes defined in `lib/themes/`
- Custom color scheme via `LightTheme().primaryGreen`
- Google Fonts: Baloo 2 (Bold 700, Medium 500)
- System UI styling set in `main.dart`
- Responsive layout: min constraints 600x1000

## Testing Strategy

- Test files in `test/` directory
- Unit tests for models and services
- Widget tests for UI components
- Integration tests for authentication flow