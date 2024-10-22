// ignore_for_file: prefer_final_fields
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:moneymonkey/pages/ProfilePages/profileScreen.dart';
import 'package:moneymonkey/screens/home.dart';

import 'package:moneymonkey/screens/marketscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> createNewUser() async {
    if (_createPasswordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords Do Not Match"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ));
    } else {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _createEmailController.text,
          password: _createPasswordController.text,
        );

        String userId = userCredential.user!.uid;
        addUserDetails(userId, _createEmailController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The email address is not valid."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (e.code == 'weak-password') {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Please Enter A Password with at least 6 characters."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (e.code == 'email-already-in-use') {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (e.code == 'network-request-failed') {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Unknown Error'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        return;
      }
    }
  }

Future<void> createUserInFirestore(String userId, String email) async {
  try {
    final userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    final userSnapshot = await userDocRef.get();

    if (!userSnapshot.exists) {
      // Adding user details to Firestore if not already present
      await addUserDetails(userId, email);
    } else {
      // If user exists, still ensure Progression sub-collection exists
      await ensureProgressionExists(userDocRef);
    }
  } catch (e) {
    print("Error creating user in Firestore: $e");
  }
}

Future<void> addUserDetails(String userId, String email) async {
  try {
    final userDocRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    final userSnapshot = await userDocRef.get();

    if (!userSnapshot.exists) {
      // Add user details
      await userDocRef.set({
        'User ID': userId,
        'Email': email,
        'Age': 0,
        'Knowledge Level': 0,
        'Learning Goal Per Day': 0
      });

      // Add profile sub-collection
      await userDocRef.collection('profile').doc('userProfile').set({
        'Full Name': 'Your Name Here',
        'Username': 'Your Name Here',
        'Number of Followers': 0,
        'Following': 0,
        'Top Achievements': 0,
        'Streak': 0,
        'Total Profit': 0,
        'Average Monthly Growth': 0,
      });
    }

    // Ensure the Progression sub-collection is created
    await ensureProgressionExists(userDocRef);
  } catch (e) {
    print("Error adding user details: $e");
  }
}
// Function to ensure Progression sub-collection exists
Future<void> ensureProgressionExists(DocumentReference userDocRef) async {
  try {
    final progressionCollectionRef = userDocRef.collection('Progression');
    final progressionSnapshot = await progressionCollectionRef.get();

    if (progressionSnapshot.docs.isEmpty) {
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
      print("Progression sub-collection created for user.");
    }
  } catch (e) {
    print("Error ensuring progression sub-collection: $e");
  }
}

  Future<void> logIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );
      String userId = userCredential.user?.uid ?? '';
        String email = userCredential.user?.email ?? '';
      if (userId.isNotEmpty && email.isNotEmpty) {
         await createUserInFirestore(userId, email);
        if (!mounted) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid Email'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'invalid-credential') {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Incorrect Email or Password'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'channel-error') {
        // Pass
      } else {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.code),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      }
    }
    
  }

  Future googleAuth() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String userId = userCredential.user?.uid ?? '';
    String email = userCredential.user?.email ?? '';
    if (email.isNotEmpty) {
      addUserDetails(userId, email);
    }
  }

  Future appleAuth() async {
    final appleProvider = AppleAuthProvider();
    UserCredential user =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
    String userId = user.user!.uid;
    String? email = user.user?.email ?? "";
    if (email.isNotEmpty) {
      addUserDetails(userId, email);
    }
  }

  // Index for create or login
  int _selectedIndex = 1;
  // Text editing controllers
  TextEditingController _createPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _createEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController _loginEmailController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _createPasswordController.dispose();
    _loginPasswordController.dispose();
    _loginEmailController.dispose();
    _confirmPasswordController.dispose();
    _createEmailController.dispose();
    super.dispose();
  }

  // Switches Screen (OLD code keeping in case we switch back)
  //void _onButtonPressed(int index) {
  //setState(() {
  //_selectedIndex = index;
  // });S
  //}

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 700,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        'assets/images/monkey.png',
                        height: 600,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        top: 170,
                        left: 10,
                        right: 10,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 10), 
                               Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome Back',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                26, 
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 10),

                                        Text(
                                          'Fill out the information below in order',
                                          style: GoogleFonts.baloo2(
                                            fontSize: 14,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          'to access your account.',
                                          style: GoogleFonts.baloo2(
                                            fontSize: 14,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                            height: 30), 
                                        SizedBox(
                                          width: 330, 
                                          height: 50, 
                                          child: TextField(
                                            controller: _loginEmailController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30), 
                                              ),
                                              labelText: 'Email',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 10), 
                                        SizedBox(
                                          width: 330, 
                                          height: 50, 
                                          child: TextField(
                                            controller:
                                                _loginPasswordController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30), 
                                              ),
                                              labelText: 'Password',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 12), 
                                        Center(
                                          child: SizedBox(
                                              width: 
                                                  240,
                                              height: 47,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  logIn();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          135, 206, 235, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30), 
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10, 
                                                      vertical: 5), 
                                                  elevation: 8,
                                                ),
                                                child: const Text(
                                                  'Log in',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        252, 252, 252, 252),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                
                                              )),
                                        ),
                                        SizedBox(
                                            height:5), // 2% of screen height
                                        Center(
                                            child: Text(
                                          "Or sign in with",
                                          style: GoogleFonts.baloo2(
                                              fontSize: 14,
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 1)),
                                        )),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: 
                                                      240, 
                                                  height: 47,
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/apple.png"),
                                                    onPressed: () {
                                                      appleAuth();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: 240, 
                                                  height: 47,
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/google.png"),
                                                    onPressed: () {
                                                      googleAuth();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 50, 5),
                                  
                                                child: TextButton(
                                                    onPressed: () {
                                                      if (!mounted) {
                                                        return;
                                                      }
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const UserProfileScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "If you are new, create a new account here",
                                                      style: GoogleFonts.baloo2(
                                                        fontSize:
                                                            14,
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 0, 0, 1),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
