# MoneyMonkey Deployment Checklist

## 🌐 WEB-ONLY DEPLOYMENT

**NOTE:** You indicated this is for web deployment only. The iOS/Android folders can be kept (they're ignored during web builds) or removed - your choice.

### What Matters for Web Deployment:
✅ Firebase configuration in `web/index.html` (already correct)
⚠️ Firestore security rules (MUST verify)
⚠️ Test web app thoroughly
⚠️ Privacy policy and terms of service

### What DOESN'T Matter for Web:
❌ Android release signing - web only
❌ iOS configuration - web only
❌ Package name changes - web only
❌ Mobile platform folders - ignored by `flutter build web`

---

## ✅ Completed Tasks

### Phase 1: AI Assistant Removal
- ✅ Deleted `lib/Backend/Services/OpenAIService.dart`
- ✅ Deleted `lib/Backend/Services/AiServiceInitializer.dart`
- ✅ Deleted `lib/Backend/Services/AssistantConfigService.dart`
- ✅ Deleted `lib/Backend/Services/test.dart` (653-line OpenAI testing file)
- ✅ Deleted `lib/Backend/Controllers/ConversationsController.dart`
- ✅ Deleted `lib/Backend/Models/ChatBotConversation.dart`
- ✅ Deleted `lib/GlobalWidgets/ChatBotDialog.dart`
- ✅ Removed floating action button from `lib/home.dart`
- ✅ Removed all AI-related methods and imports from `lib/home.dart`
- ✅ Removed AI services initialization from `lib/main.dart`
- ✅ Removed `flutter_dotenv` dependency from `pubspec.yaml`
- ✅ Deleted `keys.env` file
- ✅ Removed `keys.env` from `pubspec.yaml` assets

### Phase 2: Security & Cleanup
- ✅ Deleted `keys.env` (contained exposed OpenAI API key)
- ✅ Deleted `lib/UploadScript.dart`
- ✅ Deleted `lib/UploaderPage.dart`
- ✅ Fixed TODO comment in `ios/Runner/Info.plist`
- ✅ Removed placeholder `GIDServerClientID` from `ios/Runner/Info.plist`

### Phase 3: Platform Configuration
- ✅ Changed package name from `com.example.moneyMonkey` to `com.moneymonkey.app`
  - Updated `android/app/build.gradle` (namespace and applicationId)
  - Moved MainActivity from `com/example/money_monkey/` to `com/moneymonkey/app/`
  - Updated package declaration in `MainActivity.kt`
  - Updated `ios/Runner/GoogleService-Info.plist` BUNDLE_ID
- ✅ Fixed Android release signing configuration in `android/app/build.gradle`
  - Added `signingConfigs.release` block
  - Changed from using `signingConfigs.debug` to `signingConfigs.release`
  - Added TODO comment for production keystore creation

### Phase 4: Code Quality
- ✅ Ran `flutter pub get` successfully
- ✅ Ran `flutter analyze` - found 837 issues (mostly deprecation warnings and unused imports)

---

## ⚠️ CRITICAL - Must Complete Before WEB Production Deploy

### 1. ~~Android Release Signing~~ (NOT NEEDED FOR WEB)
**Status:** Not applicable for web-only deployment

The Android signing configuration was updated but won't be used for web deployment.

### 2. Firebase Admin SDK Key (SECURITY RISK)
**File:** `money-monkey-f4d73-firebase-adminsdk-vhr5p-e96e398198.json`

This file exists in the repository root but is gitignored. Check:
```bash
git log --all --full-history -- money-monkey-f4d73-firebase-adminsdk-vhr5p-e96e398198.json
```

If it was ever committed:
1. Rotate the service account key in Firebase Console
2. Use BFG Repo-Cleaner or git-filter-repo to remove from history
3. Force push to all branches

### 3. Check Git History for Secrets
```bash
git log --all --full-history -- keys.env
```

If `keys.env` was ever committed:
1. Rotate the OpenAI API key (even though we removed AI features)
2. Remove from git history using BFG Repo-Cleaner

### 2. Firestore Security Rules (CRITICAL FOR WEB)
**MUST verify that your Firestore rules prevent unauthorized access:**
- Users can only read/write their own `/users/{userId}` document
- Users can only access their own subcollections
- Classroom permissions properly restrict teacher features
- Test with unauthenticated requests

### 3. ~~Firebase Services Configuration~~ (NOT NEEDED FOR WEB)
**Status:** Web configuration in `web/index.html` is already correct

Mobile configuration files (google-services.json, GoogleService-Info.plist) are not used for web deployment.

---

## 🔧 High Priority - Should Fix Before Deploy

### 1. Code Analysis Issues (837 issues found)
Run `flutter analyze` output shows:
- **Deprecation warnings:** `withOpacity()` should be replaced with `.withValues()`
- **Unused imports:** Clean up unused imports throughout codebase
- **Dead code:** Remove unreachable code in budget simulator
- **Immutability issues:** Fix StatefulWidget fields marked as final

### 2. ~~Update Firebase Configuration~~ (NOT NEEDED FOR WEB)
Web Firebase configuration is already correct in `web/index.html`. Mobile configurations are not used.

### 3. Testing Requirements (WEB ONLY)
Test these critical flows in web browser:
- [ ] Sign up with email/password
- [ ] Sign in with email/password
- [ ] Google OAuth sign-in (Web - use popup method)
- [ ] Password reset flow
- [ ] Lesson completion and progress tracking
- [ ] Streak calculation (same day, consecutive days, missed days)
- [ ] Offline functionality (cache behavior with service worker if enabled)
- [ ] Budget simulator end-to-end
- [ ] Profile and settings updates
- [ ] Browser compatibility (Chrome, Firefox, Safari, Edge)
- [ ] Responsive design on different screen sizes
- [ ] Mobile browser testing (iOS Safari, Chrome Mobile)

### 4. Edge Cases to Test
**Lesson Progress:**
- What happens after reaching the end of curriculum (level Z)?
- Lesson transitions: 1→3→5→6→section→unit→level
- Progress calculation validation

**Streak Tracking:**
- Timezone differences (user travels)
- Multiple completions same day
- Exactly 24 hours between completions
- Missed day reset behavior

**Cache/Sync:**
- Offline mode functionality
- Cache invalidation scenarios
- Conflicts between cached and server data
- Corrupted cache handling

---

## 📋 Medium Priority

### 1. Environment Variables
Document required environment variables (none currently needed since AI removed)

### 2. Dependency Updates
Run `flutter pub outdated` - 5 packages have newer versions:
- characters 1.4.0 → 1.4.1
- google_fonts 6.3.1 → 6.3.2
- material_color_utilities 0.11.1 → 0.13.0
- meta 1.16.0 → 1.17.0
- test_api 0.7.6 → 0.7.7

### 3. Remove Debug Print Statements
433 print/debugPrint statements found across 64 files. Consider:
- Remove unnecessary debug prints
- Replace critical logging with proper logging framework
- Keep error logging for production debugging

### 4. Clean Up Unused Code
`flutter analyze` found:
- Unused imports (100+)
- Unused local variables
- Unused methods and functions
- Dead code branches

---

## 🚀 Before First Production Release

### 1. Legal & Compliance
- [ ] Create privacy policy for student data (COPPA/FERPA compliance)
- [ ] Create terms of service
- [ ] Add privacy policy link in app
- [ ] Add terms of service link in app
- [ ] Document data retention policies

### 2. Version Control
- [ ] Commit all changes with clear message
- [ ] Create release branch: `release/1.0.0`
- [ ] Tag release: `v1.0.0`
- [ ] Push to remote

### 3. Documentation
- [ ] Update README.md with deployment instructions
- [ ] Document environment setup
- [ ] Create user onboarding documentation
- [ ] Document emergency rollback procedures

### 4. Monitoring & Support
- [ ] Set up error tracking (Sentry, Firebase Crashlytics, etc.)
- [ ] Set up analytics (Firebase Analytics already configured)
- [ ] Create support email/contact method
- [ ] Set up monitoring alerts for critical failures

---

## 🌐 Web Deployment Notes

### Web Configuration
- Firebase config in `web/index.html` is correctly configured
- Google Sign-In uses popup method (web-specific)
- No CORS issues expected with Firebase services (first-party)

### Web Build Command
```bash
flutter build web --release
```

### Output Location
Build output will be in: `build/web/`

### Deployment Options
1. **Firebase Hosting** (recommended - already configured)
   ```bash
   firebase deploy --only hosting
   ```

2. **Other hosting** (Netlify, Vercel, etc.)
   - Upload contents of `build/web/` directory
   - Configure SPA routing (redirect all routes to index.html)

### Web-Specific Considerations
- Service worker for PWA (check `web/flutter_service_worker.js`)
- Cache strategy for assets
- Loading performance (lazy loading, code splitting)
- SEO meta tags in `web/index.html`

### Browser Support
- Modern browsers (Chrome 84+, Firefox 79+, Safari 14+, Edge 84+)
- Mobile browsers (iOS Safari 14+, Chrome Mobile)

### ~~Mobile Platforms~~ (NOT DEPLOYED)
The iOS and Android folders remain in the repository but are not used for web deployment.

---

## 🔍 Files Modified

### Deleted:
- `lib/Backend/Services/OpenAIService.dart`
- `lib/Backend/Services/AiServiceInitializer.dart`
- `lib/Backend/Services/AssistantConfigService.dart`
- `lib/Backend/Services/test.dart`
- `lib/Backend/Controllers/ConversationsController.dart`
- `lib/Backend/Models/ChatBotConversation.dart`
- `lib/GlobalWidgets/ChatBotDialog.dart`
- `lib/UploadScript.dart`
- `lib/UploaderPage.dart`
- `keys.env`
- `android/app/src/main/kotlin/com/example/` (directory)

### Modified:
- `lib/home.dart` - Removed AI assistant integration
- `lib/main.dart` - Removed AI services initialization
- `pubspec.yaml` - Removed flutter_dotenv, removed keys.env from assets
- `android/app/build.gradle` - Changed package name, added release signing config
- `ios/Runner/Info.plist` - Removed placeholder, cleaned up TODOs
- `ios/Runner/GoogleService-Info.plist` - Updated bundle ID

### Created:
- `android/app/src/main/kotlin/com/moneymonkey/app/MainActivity.kt` - New package location
- `DEPLOYMENT_CHECKLIST.md` (this file)

---

## 📞 Next Steps

1. **IMMEDIATE:** Generate production keystore and configure Android release signing
2. **BEFORE DEPLOY:** Check git history for exposed secrets
3. **BEFORE DEPLOY:** Update Firebase configuration files with new package names
4. **BEFORE DEPLOY:** Test Firestore security rules thoroughly
5. **BEFORE DEPLOY:** Complete all manual testing from checklist above
6. **RECOMMENDED:** Fix deprecation warnings from flutter analyze
7. **RECOMMENDED:** Create privacy policy and terms of service
8. **BEFORE PUBLIC RELEASE:** Complete legal compliance review

---

Last updated: 2025-09-29
Flutter version: Check with `flutter --version`
Dart SDK: ">=2.17.0 <3.0.0"