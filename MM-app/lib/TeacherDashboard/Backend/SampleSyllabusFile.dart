import 'package:money_monkey/Backend/Models/Academic.dart';

// Sample Performance Trends
final mockPerformanceTrends = PerformanceTrends(
  label: 'Week 1',
  classAverage: 85.5,
  participationRate: 92.0,
  lessonCompletion: 78.5,
  lastUpdated: DateTime.now(),
);

// Sample Components
final Map<String, Component> mockComponents = {
  'comp1': Component(
    componentId: 'comp1',
    lessonId: 'lesson1',
    title: 'Introduction to the Topic',
    type: ComponentType.concept,
    componentStatus: Status.active,
    progress: 100.0,
    discussionQuestions: [
      'What are your thoughts on this concept?',
      'How would you apply this in real life?'
    ],
  ),
  'comp2': Component(
    componentId: 'comp2',
    lessonId: 'lesson1',
    title: 'Interactive Exercise',
    type: ComponentType.interactiveActivity,
    componentStatus: Status.inProgress,
    progress: 60.0,
    questionData: {
      'questions': [
        {'text': 'What is the main idea?', 'correctAnswer': 'Growth mindset'},
        {'text': 'How does it work?', 'correctAnswer': 'Through practice'}
      ]
    },
  ),
  'comp3': Component(
    componentId: 'comp3',
    lessonId: 'lesson1',
    title: 'Final Quiz',
    type: ComponentType.quiz,
    componentStatus: Status.inactive,
    progress: 0.0,
  ),
};

// Sample Lessons
final Map<String, Lesson> mockLessons = {
  'lesson1': Lesson(
    lessonId: 'lesson1',
    unitId: 'unit1',
    title: 'Understanding Core Concepts',
    description: 'An introduction to the fundamental principles',
    lessonStatus: Status.inProgress,
    components: mockComponents,
    progress: 65.0,
    discussionQuestions: [
      'What was your biggest takeaway?',
      'How can we improve this process?'
    ],
    performanceTrends: mockPerformanceTrends,
    startedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  'lesson2': Lesson(
    lessonId: 'lesson2',
    unitId: 'unit1',
    title: 'Advanced Applications',
    description: 'Taking your knowledge to the next level',
    lessonStatus: Status.inactive,
    components: {},
    progress: 0.0,
    discussionQuestions: [],
    performanceTrends: PerformanceTrends(
      label: 'Not Started',
      classAverage: 0.0,
      participationRate: 0.0,
      lessonCompletion: 0.0,
    ),
  ),
};

// Sample Units
final Map<String, Unit> mockUnits = {
  'unit1': Unit(
    unitId: 'unit1',
    title: 'Getting Started',
    description: 'The foundation of our learning journey',
    lessonIds: ['lesson1', 'lesson2'],
    difficulty: 'Intermediate',
    unitStatus: Status.active,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
  ),
  'unit2': Unit(
    unitId: 'unit2',
    title: 'Advanced Topics',
    description: 'Deep dive into complex subjects',
    lessonIds: [],
    difficulty: 'Advanced',
    unitStatus: Status.inactive,
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    updatedAt: DateTime.now(),
  ),
};

// Sample Classrooms
final Map<String, Classroom> mockClassrooms = {
  'class1': Classroom(
    classId: 'class1',
    name: 'Morning Session A',
    teacherId: 'teacher1',
    studentIds: ['student1', 'student2', 'student3'],
    lessonId: 'lesson1',
    upcomingLessonId: 'lesson2',
  ),
  'class2': Classroom(
    classId: 'class2',
    name: 'Afternoon Session B',
    teacherId: 'teacher2',
    studentIds: ['student4', 'student5', 'student6', 'student7'],
    lessonId: 'lesson2',
    upcomingLessonId: '',
  ),
};

// Helper function to get a classroom by ID
Classroom? getClassroomById(String id) {
  return mockClassrooms[id];
}

// Helper function to get a unit by ID
Unit? getUnitById(String id) {
  return mockUnits[id];
}

// Helper function to get a lesson by ID
Lesson? getLessonById(String id) {
  return mockLessons[id];
}

// Helper function to get a component by ID
Component? getComponentById(String lessonId, String componentId) {
  return mockLessons[lessonId]?.components[componentId];
}
