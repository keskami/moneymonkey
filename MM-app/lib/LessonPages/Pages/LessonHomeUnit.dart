import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading_wrapper.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonHome/custom_polygon_lines_row.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonHome/custom_polygon_row.dart';

class LessonsHomeUnit extends StatefulWidget {
  final List<Lesson> lessons;

  const LessonsHomeUnit({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  @override
  State<LessonsHomeUnit> createState() => _LessonsHomeUnitState();
}

class _LessonsHomeUnitState extends State<LessonsHomeUnit> {
  // UI constants
  late double polygonWidth;
  late double screenHeight;
  late double screenWidth;

  // Configurations
  final List<int> lessonTypes = [0, 1, 2, 3, 4, 5, 6];
  final List<String> imageLinks = [
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbulb.png?alt=media&token=f5d89615-3c3a-48fe-9b30-2aa31a1bf293",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbrain.png?alt=media&token=69ff0773-b9d8-49e3-97a0-4cb5dd7fc54a",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fbook_flip.png?alt=media&token=3f656860-1051-4dce-9b16-f7d4a82424ef",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Frecycle.png?alt=media&token=5de6e03b-2372-4e64-9635-4cff8d3839e2",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fpeer-to-peer.png?alt=media&token=1a8e499b-0e9c-4f30-89d5-8b73969b77da",
    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%20Icons%2Fcircle_question.png?alt=media&token=b89a30a9-cc6a-4710-aea6-105ece4ee36c",
  ];

  // Services
  final _firebaseService = DirectFirebaseService();
  
  // Cache for component data to prevent repeated fetching
  final Map<String, Component> _componentCache = {};
  
  // Cache for page widgets to prevent rebuilding
  final Map<String, List<Widget>> _pagesCache = {};
  
  // Store all lesson section widgets
  List<Widget>? _cachedLessonWidgets;

  // Flag to track if initial data load is complete
  bool _initialLoadComplete = false;

  @override
  void initState() {
    super.initState();
    _prefetchLessonData();
  }
  
  @override
  void didUpdateWidget(LessonsHomeUnit oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only reload if lessons have changed
    if (oldWidget.lessons != widget.lessons) {
      _cachedLessonWidgets = null;
      _prefetchLessonData();
    }
  }

  // Prefetch all lesson data on widget initialization
  Future<void> _prefetchLessonData() async {
    if (widget.lessons.isEmpty) return;
    
    try {
      // Pre-build all lesson sections in the background
      final List<Widget> lessonWidgets = [];
      
      for (Lesson lesson in widget.lessons) {
        // Pre-fetch components for each lesson
        final List<String> componentIds = lesson.components ?? [];
        if (componentIds.isNotEmpty) {
          await _prefetchComponents(componentIds);
        }
        
        final lessonWidget = await _buildLessonSection(lesson);
        lessonWidgets.add(Container(child: lessonWidget));
      }
      
      // Update the cache only if the widget is still mounted
      if (mounted) {
        setState(() {
          _cachedLessonWidgets = lessonWidgets;
          _initialLoadComplete = true;
        });
      }
    } catch (e) {
      print("Error prefetching lesson data: $e");
      if (mounted) {
        setState(() => _initialLoadComplete = true);
      }
    }
  }
  
  // Prefetch and cache components
  Future<void> _prefetchComponents(List<String> componentIds) async {
    for (String componentId in componentIds) {
      // Skip already cached components
      if (_componentCache.containsKey(componentId)) continue;
      
      try {
        final component = await _firebaseService.getComponent(componentId);
        _componentCache[componentId] = component;
      } catch (e) {
        print("Error prefetching component $componentId: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update dimensions once per build
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    polygonWidth = screenWidth * 0.07;

    // Choose layout based on screen dimensions
    return screenWidth > screenHeight ? _webDisplayBuilder() : _mobileDisplay();
  }

  /// Load components and create page links for a lesson
  Future<List<Widget>> getPages(List<String> componentIds) async {
    // Return cached pages if available
    final cacheKey = componentIds.join(',');
    if (_pagesCache.containsKey(cacheKey)) {
      return _pagesCache[cacheKey]!;
    }
    
    final List<Widget> pagesLink = [];
    
    // If componentIds is null or empty, return empty list with placeholders
    if (componentIds.isEmpty) {
      print("Warning: No component IDs provided");
      // Add placeholder widgets to match lessonTypes length
      return List.generate(lessonTypes.length, (_) => Container());
    }

    try {
      for (String componentId in componentIds) {
        try {
          // Use cached component data if available
          Component component;
          if (_componentCache.containsKey(componentId)) {
            component = _componentCache[componentId]!;
          } else {
            // Fetch and cache only if not already cached
            component = await _firebaseService.getComponent(componentId);
            _componentCache[componentId] = component;
          }
          
          pagesLink.add(
              LoadingPageWrapper(type: component.type, componentId: componentId));
        } catch (e) {
          print("Error fetching component $componentId: $e");
          // Add a placeholder for this component
          pagesLink.add(Container());
        }
      }
    } catch (e) {
      print("Error loading pages: $e");
    }
    
    // Make sure we have enough items for all lessonTypes
    while (pagesLink.length < lessonTypes.length) {
      pagesLink.add(Container());
    }
    
    // Cache the result for future use
    _pagesCache[cacheKey] = pagesLink;
    
    return pagesLink;
  }

  /// WEB layout builder
  Widget _webDisplayBuilder() {
    // If initial loading is not complete, show a loading indicator
    if (!_initialLoadComplete) {
      return _buildLoadingIndicator();
    }
    
    // If cached lesson widgets are available, use them
    if (_cachedLessonWidgets != null) {
      return _buildWebLayout(_cachedLessonWidgets!);
    }
    
    // Fallback to FutureBuilder if cache is not ready
    return FutureBuilder<List<Widget>>(
      future: _buildLessonSections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorDisplay(snapshot.error);
        } else if (snapshot.hasData) {
          return _buildWebLayout(snapshot.data!);
        } else {
          return const Center(child: Text("No lessons available"));
        }
      },
    );
  }

  /// Build the web layout with given lesson widgets
  Widget _buildWebLayout(List<Widget> lessonWidgets) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT side: lessons column
        SizedBox(
          width: screenWidth * 0.5,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.05),
              child: Column(children: lessonWidgets),
            ),
          ),
        ),
        // RIGHT side: scoreboard space
        SizedBox(width: screenWidth * 0.3),
      ],
    );
  }

  /// Loading indicator widget
  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text("Loading lessons..."),
        ],
      ),
    );
  }

  /// Error display widget
  Widget _buildErrorDisplay(Object? error) {
    return Center(
      child: Text("Error loading lessons: $error"),
    );
  }

  /// Build all lesson sections
  Future<List<Widget>> _buildLessonSections() async {
    // Return cached lesson widgets if available
    if (_cachedLessonWidgets != null) {
      return _cachedLessonWidgets!;
    }
    
    List<Widget> lessonWidgets = [];

    for (Lesson lesson in widget.lessons) {
      try {
        final lessonWidget = await _buildLessonSection(lesson);
        lessonWidgets.add(Container(child: lessonWidget));
      } catch (e) {
        print("Error building lesson section: $e");
      }
    }
    
    // Cache the result for future use
    _cachedLessonWidgets = lessonWidgets;

    return lessonWidgets;
  }

  /// MOBILE layout
  Widget _mobileDisplay() {
    // If initial loading is not complete, show a loading indicator
    if (!_initialLoadComplete) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lessons')),
        body: _buildLoadingIndicator(),
      );
    }
    
    // If cached lesson widgets are available, use them directly
    if (_cachedLessonWidgets != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lessons')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: _cachedLessonWidgets!.map((widget) => 
                Container(
                  margin: const EdgeInsets.only(bottom: 250),
                  child: widget,
                )
              ).toList(),
            ),
          ),
        ),
      );
    }
    
    // Fallback to original implementation if cache is not ready
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Widget>>(
                future: Future.wait(
                  widget.lessons.map((lesson) async {
                    try {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 250),
                        child: await _buildLessonSection(lesson),
                      );
                    } catch (e) {
                      print("Error building mobile lesson: $e");
                      return Container();
                    }
                  }),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingIndicator();
                  } else if (snapshot.hasData) {
                    // Cache the result for future use
                    _cachedLessonWidgets = snapshot.data!;
                    return Column(children: snapshot.data!);
                  } else {
                    return _buildErrorDisplay(snapshot.error);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds one lesson section
  Future<Widget> _buildLessonSection(Lesson lesson) async {
    // Safely get components, handling potential null
    final List<String> componentIds = lesson.components ?? [];
    
    if (componentIds.isEmpty) {
      print("Warning: Lesson has no components: ${lesson.title}");
    }

    List<Widget> pagesLink = await getPages(componentIds);
    
    // Create slant lines column (static content)
    final slantLinesColumn = Column(
      children: [
        SizedBox(height: screenHeight * 0.1),
        for (int i = 0; i < lessonTypes.length; i++)
          CustomPolygonLinesRow(
            index: lessonTypes[i],
            isActivated: false,
            width: polygonWidth,
          ),
      ],
    );

    // Create polygon lesson column
    final polygonLessonColumn = Column(
      children: [
        SizedBox(height: screenHeight * 0.1),
        for (int i = 0; i < lessonTypes.length; i++)
          CustomPolygonRow(
            key: ValueKey('${lesson.lessonId}_polygon_$i'), // Add key for stable identity
            index: i,
            isActivated: true,
            width: polygonWidth,
            imageLinks: imageLinks,
            pagesLink: pagesLink,
          ),
      ],
    );

    return Transform.scale(
      scale: 0.85,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              slantLinesColumn,
              polygonLessonColumn,
            ],
          ).marginSymmetric(horizontal: screenWidth * 0.08),
        ],
      ),
    );
  }
}