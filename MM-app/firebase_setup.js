// Firebase Setup Script for Learning Platform
// Run this in Node.js environment

const admin = require('firebase-admin');

// Initialize Firebase Admin (you'll need to add your service account key)
const serviceAccount = require('./money-monkey-f4d73-firebase-adminsdk-vhr5p-e96e398198');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://money-monkey-f4d73-default-rtdb.firebaseio.com'
});

const db = admin.firestore();

// Sample data creation function
async function createSampleData() {
  try {
    console.log('Creating sample users and profiles...');

    // Create sample students with Auth UIDs as document IDs
    const students = [
      {
        userId: 'kJ8mNpQrStUvWxYz1A2bCdEf3G4h', // This would be a real Firebase Auth UID
        userData: {
          // Basic user info
          email: 'alice@student.com',
          name: 'Alice Johnson',
          role: 'student',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          isActive: true,
          
          // Student-specific data (flattened)
          age: 22,
          classrooms: {
            tempClassId1_2025: true,
            tempClassId2_2025: true
          },
          knowledgeLevel: 3,
          learningGoalPerDay: 5,
          phoneNumber: '+1234567890',
          startingLevel: 1,
          progress: 'A.1.2.6',
          
          // Profile data
          profile: {
            averageMonthlyGrowth: 7.5,
            following: 100,
            fullName: 'Alice Johnson',
            numberOfFollowers: 1500,
            portfolioScore: 88.4,
            streak: 30,
            topAchievements: 5,
            totalProfit: 2500.75,
            username: 'alice_j_25'
          },
          
          // Settings
          settings: {
            notifications: {
              announcements: {
                educationalTipsEmail: false,
                educationalTipsPhone: true,
                marketingNotificationsEmail: true,
                marketingNotificationsPhone: true
              },
              friends: {
                friendActivityEmail: true,
                friendActivityPhone: false,
                newFollowerEmail: true,
                newFollowerPhone: false
              },
              reminders: {
                practiceEmail: true,
                practicePhone: false,
                reminderTime: '07:30 AM',
                weeklyProgress: true
              }
            },
            preferences: {
              audio: true,
              darkMode: true,
              soundEffects: true
            },
            privacySettings: {
              publicProfile: true
            }
          }
        }
      },
      {
        userId: 'mN9oQpRsUtVwXyZ2B3cDeF4G5h6i', // This would be a real Firebase Auth UID
        userData: {
          // Basic user info
          email: 'bob@student.com',
          name: 'Bob Smith',
          role: 'student',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          isActive: true,
          
          // Student-specific data (flattened)
          age: 19,
          classrooms: {
            tempClassId1_2025: true,
            tempClassId3_2025: true
          },
          knowledgeLevel: 2,
          learningGoalPerDay: 3,
          phoneNumber: '+1234567891',
          startingLevel: 1,
          progress: 'A.1.1.3',
          
          // Profile data
          profile: {
            averageMonthlyGrowth: 5.2,
            following: 75,
            fullName: 'Bob Smith',
            numberOfFollowers: 850,
            portfolioScore: 72.1,
            streak: 15,
            topAchievements: 3,
            totalProfit: 1200.50,
            username: 'bob_smith_99'
          },
          
          // Settings
          settings: {
            notifications: {
              announcements: {
                educationalTipsEmail: true,
                educationalTipsPhone: false,
                marketingNotificationsEmail: false,
                marketingNotificationsPhone: true
              },
              friends: {
                friendActivityEmail: false,
                friendActivityPhone: true,
                newFollowerEmail: false,
                newFollowerPhone: true
              },
              reminders: {
                practiceEmail: false,
                practicePhone: true,
                reminderTime: '08:00 AM',
                weeklyProgress: false
              }
            },
            preferences: {
              audio: false,
              darkMode: false,
              soundEffects: false
            },
            privacySettings: {
              publicProfile: false
            }
          }
        }
      },
      {
        userId: 'nO0pQrStUvWxYzA1B2cDeFg3H4i5', // This would be a real Firebase Auth UID
        userData: {
          // Basic user info
          email: 'charlie@student.com',
          name: 'Charlie Wilson',
          role: 'student',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          isActive: true,
          
          // Student-specific data (flattened)
          age: 20,
          classrooms: {
            tempClassId2_2025: true,
            tempClassId3_2025: true
          },
          knowledgeLevel: 4,
          learningGoalPerDay: 7,
          phoneNumber: '+1234567892',
          startingLevel: 1,
          progress: 'A.2.1.4',
          
          // Profile data
          profile: {
            averageMonthlyGrowth: 9.1,
            following: 200,
            fullName: 'Charlie Wilson',
            numberOfFollowers: 2100,
            portfolioScore: 94.7,
            streak: 45,
            topAchievements: 8,
            totalProfit: 4200.25,
            username: 'charlie_trader'
          },
          
          // Settings
          settings: {
            notifications: {
              announcements: {
                educationalTipsEmail: true,
                educationalTipsPhone: true,
                marketingNotificationsEmail: true,
                marketingNotificationsPhone: false
              },
              friends: {
                friendActivityEmail: true,
                friendActivityPhone: true,
                newFollowerEmail: true,
                newFollowerPhone: true
              },
              reminders: {
                practiceEmail: true,
                practicePhone: true,
                reminderTime: '06:00 AM',
                weeklyProgress: true
              }
            },
            preferences: {
              audio: true,
              darkMode: true,
              soundEffects: true
            },
            privacySettings: {
              publicProfile: true
            }
          }
        }
      }
    ];

    // Create sample teachers (flat structure)
    const teachers = [
      {
        userId: 'teacher_001',
        userData: {
          // Basic user info
          email: 'dr.wilson@school.com',
          name: 'Dr. Emily Wilson',
          role: 'teacher',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          isActive: true,
          
          // Teacher-specific data
          employeeId: 'T001',
          subjects: ['mathematics', 'physics'],
          classes: ['10A', '10B', '11A'],
          experience: '8 years',
          qualifications: ['PhD Mathematics', 'MEd Physics'],
          department: 'Science',
          officeHours: {
            monday: '2:00 PM - 4:00 PM',
            wednesday: '2:00 PM - 4:00 PM',
            friday: '1:00 PM - 3:00 PM'
          }
        }
      },
      {
        userId: 'teacher_002',
        userData: {
          // Basic user info
          email: 'prof.davis@school.com',
          name: 'Prof. Michael Davis',
          role: 'teacher',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          isActive: true,
          
          // Teacher-specific data
          employeeId: 'T002',
          subjects: ['chemistry', 'biology'],
          classes: ['9A', '10C', '11B'],
          experience: '12 years',
          qualifications: ['PhD Chemistry', 'MSc Biology'],
          department: 'Science',
          officeHours: {
            tuesday: '3:00 PM - 5:00 PM',
            thursday: '3:00 PM - 5:00 PM'
          }
        }
      }
    ];

    // Create students in Firestore (flat structure - no subcollections)
    for (const student of students) {
      // Create user document with all data in one place
      await db.collection('users').doc(student.userId).set(student.userData);
      console.log(`Created user: ${student.userData.name} (${student.userData.role})`);
    }

    // Create teachers in Firestore (flat structure)
    for (const teacher of teachers) {
      // Create user document with all data in one place  
      await db.collection('users').doc(teacher.userId).set(teacher.userData);
      console.log(`Created user: ${teacher.userData.name} (${teacher.userData.role})`);
    }

    console.log('✅ All sample data created successfully!');

  } catch (error) {
    console.error('❌ Error creating sample data:', error);
  }
}

// Function to create additional collections for your learning platform
async function createSupportingCollections() {
  try {
    console.log('Creating supporting collections...');

    // Create sample courses
    const courses = [
      {
        courseId: 'math_101',
        title: 'Algebra I',
        description: 'Introduction to algebraic concepts',
        subject: 'mathematics',
        grade: '9th',
        teacher: 'teacher_001',
        students: ['student_001', 'student_002'],
        schedule: {
          days: ['monday', 'wednesday', 'friday'],
          time: '9:00 AM - 10:00 AM'
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      },
      {
        courseId: 'phys_201',
        title: 'Physics II',
        description: 'Advanced physics concepts',
        subject: 'physics',
        grade: '11th',
        teacher: 'teacher_001',
        students: ['student_001'],
        schedule: {
          days: ['tuesday', 'thursday'],
          time: '10:00 AM - 11:30 AM'
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      }
    ];

    // Create courses collection
    for (const course of courses) {
      await db.collection('courses').doc(course.courseId).set(course);
      console.log(`Created course: ${course.title}`);
    }

    // Create sample assignments
    const assignments = [
      {
        assignmentId: 'assign_001',
        title: 'Quadratic Equations Worksheet',
        description: 'Solve problems 1-20 on page 45',
        courseId: 'math_101',
        teacherId: 'teacher_001',
        dueDate: new Date('2024-10-15'),
        totalPoints: 100,
        assignedStudents: ['student_001', 'student_002'],
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      }
    ];

    // Create assignments collection
    for (const assignment of assignments) {
      await db.collection('assignments').doc(assignment.assignmentId).set(assignment);
      console.log(`Created assignment: ${assignment.title}`);
    }

    console.log('✅ Supporting collections created successfully!');

  } catch (error) {
    console.error('❌ Error creating supporting collections:', error);
  }
}

// Helper functions for querying data
async function queryExamples() {
  console.log('\n--- Query Examples ---');

  try {
    // Example 1: Get all students
    console.log('\n1. Getting all students:');
    const studentsSnapshot = await db.collection('users')
      .where('role', '==', 'student')
      .get();
    
    studentsSnapshot.forEach(doc => {
      console.log(`Student: ${doc.data().name} (${doc.data().email})`);
    });

    // Example 2: Get complete student data (single read!)
    console.log('\n2. Getting complete student data:');
    const studentDoc = await db.collection('users').doc('student_001').get();

    if (studentDoc.exists) {
      const data = studentDoc.data();
      console.log(`Student: ${data.name}`);
      console.log(`Portfolio Score: ${data.profile.portfolioScore}`);
      console.log(`Knowledge Level: ${data.knowledgeLevel}`);
      console.log(`Streak: ${data.profile.streak} days`);
      console.log(`Dark Mode: ${data.settings.preferences.darkMode}`);
    }

    // Example 3: Get students with high portfolio scores (single query!)
    console.log('\n3. Getting high-performing students:');
    const highPerformersSnapshot = await db.collection('users')
      .where('role', '==', 'student')
      .where('profile.portfolioScore', '>', 80)
      .get();

    highPerformersSnapshot.forEach(doc => {
      const data = doc.data();
      console.log(`High performer: ${data.name} - Score: ${data.profile.portfolioScore}`);
    });

    // Example 4: Get students by knowledge level
    console.log('\n4. Getting advanced students (knowledge level 3+):');
    const advancedStudentsSnapshot = await db.collection('users')
      .where('role', '==', 'student')
      .where('knowledgeLevel', '>=', 3)
      .get();

    advancedStudentsSnapshot.forEach(doc => {
      const data = doc.data();
      console.log(`Advanced: ${data.name} - Level: ${data.knowledgeLevel}, Progress: ${data.progress}`);
    });

  } catch (error) {
    console.error('Error in query examples:', error);
  }
}

// Main execution function
async function main() {
  await createSampleData();
  await createSupportingCollections();
  await queryExamples();
  
  console.log('\n🎉 Firebase setup complete!');
  process.exit(0);
}

// Run the setup
main().catch(console.error);

// Export functions for individual use
module.exports = {
  createSampleData,
  createSupportingCollections,
  queryExamples
};