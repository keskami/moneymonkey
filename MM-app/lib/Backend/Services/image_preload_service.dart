import 'package:flutter/material.dart';

/// Service to handle preloading of images used in the app
/// This prevents loading delays when images are first displayed
class ImagePreloadService {
  /// Network images from Firebase Storage used in getting started flow
  static const List<String> gettingStartedImages = [
    // Most frequently used - money monkey (appears in 8+ pages)
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
    
    // Getting started intro pages
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMONKEYMONEY%20(91).png?alt=media&token=d9a9d290-db60-4355-b779-8734d09e52a4",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgetting_started_home.png?alt=media&token=c16b00a6-23b1-486b-bdb6-71effbf4fb24",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FYour%20paragraph%20text%20(36).png?alt=media&token=4b9aae56-7e3a-4e84-82ca-99b2265bcc1b",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_blackboard.png?alt=media&token=08191299-2a7a-41e3-8965-3e6ee3e52eeb",
    
    // Start fresh pages icons
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Frework.png?alt=media&token=7988b569-33ea-461d-9030-a0e8b5d3cfb4",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fblue_icon.png?alt=media&token=8a2e6bb8-acaa-4d41-835a-9005a28fe3be",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fwatch.png?alt=media&token=e424e7dc-cdec-4174-bfcb-ad754d45c093",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fone_banner.png?alt=media&token=9bf102b7-d285-413f-8fee-27c384fc9ed2",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fmagnifying_glass.png?alt=media&token=5efa79cc-9435-4b27-9cb0-75ea22b18bb5",
    
    // Sign up page social login icons
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fgoogle_logo.png?alt=media&token=b1cc9b7e-785b-4af5-9e37-9af74d69eeb9",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Ffacebook_logo.png?alt=media&token=a1810c16-71d9-4537-9201-6d7c47d22577",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fapple_logo.png?alt=media&token=151b1835-0e40-4bf7-b6d2-61dc70de963b",
  ];

  /// Network images from Firebase Storage used in home page and lessons
  static const List<String> homePageImages = [
    // Lesson home page images
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonFlowImages%2FgoldTreasure.png?alt=media&token=2299e888-e835-414e-ac4a-0e260fa44e2a",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Fmonkey_question.png?alt=media&token=248dc316-1996-4305-a98a-ece166e7cb27",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLessonBananaReward.png?alt=media&token=9ff7a738-ad66-4f7b-a9e2-7a6c451284a6",
    
    // Commonly used monkeys
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
    
    // Lesson component images
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FWrong%20X.png?alt=media&token=7502b819-8b30-4120-8222-305534358c8c",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FStoryPages%2FDIamond.png?alt=media&token=98ad4d6e-dbda-4112-9e0c-d0429eef9d37",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb",
    
    // Lesson 1 icons
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
    
    // Story page images
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fsneakers%201.png?alt=media&token=625bdbab-4e8d-42cd-82b4-8f79a1bedf3f",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fcollege%201.png?alt=media&token=cd5510da-9563-41a8-a2eb-bd13594312a3",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Factivities%201.png?alt=media&token=8a2aa7b5-e154-4aa9-ae20-44cfc38e01a7",
    
    // Celebration GIF
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Gifs%2Fcelebration_animation_GIF.gif?alt=media&token=10d648af-02e3-4c34-8672-71d38133adfa",
  ];

  /// Local asset images used in sidebar navigation
  static const List<String> sidebarAssets = [
    'assets/images/globemonkey.png',
    'assets/images/treasure.png',
    'assets/images/bottommonkey.png',
    'assets/images/HomeWorkPage.png',
    'assets/images/BudgetSimulator.png',
    'assets/images/bluemonkey.png',
  ];

  /// Local asset images used in scoreboard widget
  static const List<String> scoreboardAssets = [
    'assets/images/LOGO.png',
    'assets/images/img_monkeymoney_52.png',
    'assets/images/img_monkeymoney_51.png',
  ];

  /// Local asset images used in login page
  static const List<String> loginAssets = [
    'assets/images/monkey.png',
    'assets/images/apple.png',
    'assets/images/google.png',
  ];

  /// Preload all getting started and login flow images
  /// 
  /// This should be called before showing the getting started or login screens
  /// to ensure images are cached and display instantly.
  /// 
  /// Returns a Future that completes when all images are loaded.
  static Future<void> preloadGettingStartedImages(BuildContext context) async {
    try {
      // Preload network images in parallel
      await Future.wait(
        gettingStartedImages.map(
          (url) => precacheImage(
            NetworkImage(url),
            context,
          ).catchError((error) {
            // Log error but don't fail the entire preload
            debugPrint('Failed to preload image: $url - $error');
          }),
        ),
      );

      // Preload local assets in parallel
      await Future.wait(
        loginAssets.map(
          (path) => precacheImage(
            AssetImage(path),
            context,
          ).catchError((error) {
            // Log error but don't fail the entire preload
            debugPrint('Failed to preload asset: $path - $error');
          }),
        ),
      );
    } catch (e) {
      // Log but don't throw - app should still work even if preload fails
      debugPrint('Error during image preloading: $e');
    }
  }

  /// Preload all home page and sidebar images
  /// 
  /// This should be called after user logs in to ensure all images
  /// in the main app are cached before displaying the home page.
  /// 
  /// Returns a Future that completes when all images are loaded.
  static Future<void> preloadHomePageImages(BuildContext context) async {
    final startTime = DateTime.now();
    
    try {
      debugPrint('🎨 Starting home page image preload...');
      
      // Ensure minimum loading time to show the loading screen
      // and prevent flashing if images load too fast from browser cache
      final preloadFuture = Future.wait([
        // Preload Firebase Storage images in parallel
        Future.wait(
          homePageImages.map(
            (url) => precacheImage(
              NetworkImage(url),
              context,
            ).catchError((error) {
              debugPrint('Failed to preload image: $url - $error');
            }),
          ),
        ),
        // Preload sidebar assets in parallel
        Future.wait(
          sidebarAssets.map(
            (path) => precacheImage(
              AssetImage(path),
              context,
            ).catchError((error) {
              debugPrint('Failed to preload asset: $path - $error');
            }),
          ),
        ),
        // Preload scoreboard assets in parallel
        Future.wait(
          scoreboardAssets.map(
            (path) => precacheImage(
              AssetImage(path),
              context,
            ).catchError((error) {
              debugPrint('Failed to preload asset: $path - $error');
            }),
          ),
        ),
      ]);
      
      // Wait for both preloading and minimum display time
      await Future.wait([
        preloadFuture,
        Future.delayed(Duration(milliseconds: 800)), // Minimum loading screen time
      ]);
      
      final duration = DateTime.now().difference(startTime);
      debugPrint('✅ Home page image preload complete! Took ${duration.inMilliseconds}ms');
      debugPrint('   - ${homePageImages.length} Firebase images');
      debugPrint('   - ${sidebarAssets.length} sidebar assets');
      debugPrint('   - ${scoreboardAssets.length} scoreboard assets');
    } catch (e) {
      debugPrint('Error during home page image preloading: $e');
    }
  }

  /// Preload all images for the entire app (getting started + home page)
  /// 
  /// This is a convenience method that preloads everything.
  /// Use this if you want to preload all images at once.
  static Future<void> preloadAllImages(BuildContext context) async {
    try {
      debugPrint('🎨 Starting complete app image preload...');
      
      // Run both preload operations in parallel
      await Future.wait([
        preloadGettingStartedImages(context),
        preloadHomePageImages(context),
      ]);
      
      debugPrint('✅ Complete app image preload finished!');
    } catch (e) {
      debugPrint('Error during complete image preloading: $e');
    }
  }
}
