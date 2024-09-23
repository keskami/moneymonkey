// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_monkey/pages/profileScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green, 
        statusBarIconBrightness: Brightness.light,
      ),
    );
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
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The email address is not valid."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (e.code == 'weak-password') {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Please Enter A Password with at least 6 characters."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        } else if (e.code == 'email-already-in-use') {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        return;
      }
    }
  }

  Future<void> addUserDetails(String userId, String email) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);

    //
    await userDocRef.set({
      'User ID': userId,
      'Email': email,
      'Age': 0,
      'Knowledge Level': 0,
      'Learning Goal Per Day': 0
    });

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

  Future<void> logIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );
      String userId = userCredential.user?.uid ?? '';
      if (userId.isNotEmpty) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfileScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid Email'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'invalid-credential') {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Incorrect Email or Password'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ));
      } else if (e.code == 'channel-error') {
        // Pass
      }
      else {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.01, // 1% of screen height
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                SizedBox(
                  height: screenHeight * 1, // 90% of screen height
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        'assets/images/monkey.png',
                        height: screenHeight * 0.5, // 50% of screen height
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        top: screenHeight * 0.22, // 30% of screen height
                        left: screenWidth * 0.025, // 2% of screen width
                        right: screenWidth * 0.025, // 2% of screen width
                        bottom: screenHeight * -1, // 5% of screen height
                        child: Container(
                          padding: EdgeInsets.all(
                              screenWidth * 0.05), // 5% of screen width
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                                screenWidth * 0.05), // 5% of screen width
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: screenHeight *
                                      0.025), // 3% of screen height
                              _selectedIndex > 1000000000000000 // here so it is never there. Want to keep old code for future use
                                  ? SingleChildScrollView(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Create Account',
                                          style: TextStyle(
                                              fontSize:
                                                  22, // 3% of screen height
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        //Fill out the information below in order
//to access your account.
                                        Text(
                                          'Let’s get started by filling out the form below.',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.02, // 2% of screen height
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),

                                        SizedBox(
                                            height: screenHeight *
                                                0.02), // 2% of screen height
                                        SizedBox(
                                          width: screenWidth *
                                              0.8, // 80% of screen width
                                          height: screenHeight *
                                              0.06, // 7% of screen height
                                          child: TextField(
                                            controller: _createEmailController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(screenWidth *
                                                        0.1), // 10% of screen width
                                              ),
                                              labelText: 'Email',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.01), // 1% of screen height
                                        SizedBox(
                                          width: screenWidth *
                                              0.8, // 80% of screen width
                                          height: screenHeight *
                                              0.06, // 7% of screen height
                                          child: TextField(
                                            controller:
                                                _createPasswordController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(screenWidth *
                                                        0.1), // 10% of screen width
                                              ),
                                              labelText: 'Password',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.01), // 1% of screen height
                                        SizedBox(
                                          width: screenWidth *
                                              0.8, // 80% of screen width
                                          height: screenHeight *
                                              0.06, // 7% of screen height
                                          child: TextField(
                                            controller:
                                                _confirmPasswordController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(screenWidth *
                                                        0.1), // 10% of screen width
                                              ),
                                              labelText: 'Confirm Password',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.02), // 2% of screen height
                                        Center(
                                          child: SizedBox(
                                              width: screenWidth *
                                                  0.6, // 60% of screen width
                                              height: screenHeight *
                                                  0.07, // 7% of screen height
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  createNewUser();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          135, 206, 235, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(screenWidth *
                                                            0.07), // 7% of screen width
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: screenWidth *
                                                          0.05, // 5% of screen width
                                                      vertical: screenHeight *
                                                          0.01), // 2% of screen height
                                                  elevation: 8,
                                                ),
                                                child: const Text(
                                                  'Get Started',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        252, 252, 252, 252),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.02), // 2% of screen height
                                        const Center(
                                            child: Text(
                                          "Or sign up with",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Ballo 2",
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        )),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: screenWidth *
                                                    0.6, // 60% of screen width
                                                height: screenHeight *
                                                    0.07, // 7% of screen height
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      "assets/images/image.png"),
                                                  onPressed: () {
                                                    appleAuth();
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth *
                                                    0.6, // 60% of screen width
                                                height: screenHeight *
                                                    0.07, // 7% of screen height
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      "assets/images/image2.png"),
                                                  onPressed: () {
                                                    googleAuth();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome Back',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.03, // 3% of screen height
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: screenHeight * .02),

                                        Text(
                                          'Fill out the information below in order',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.02, // 2% of screen height
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          'to access your account.',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.02, // 2% of screen height
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.04), // 2% of screen height
                                        SizedBox(
                                          width: screenWidth *
                                              0.8, // 80% of screen width
                                          height: screenHeight *
                                              0.07, // 7% of screen height
                                          child: TextField(
                                            controller: _loginEmailController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(screenWidth *
                                                        0.1), // 10% of screen width
                                              ),
                                              labelText: 'Email',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.01), // 1% of screen height
                                        SizedBox(
                                          width: screenWidth *
                                              0.8, // 80% of screen width
                                          height: screenHeight *
                                              0.07, // 7% of screen height
                                          child: TextField(
                                            controller:
                                                _loginPasswordController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(screenWidth *
                                                        0.1), // 10% of screen width
                                              ),
                                              labelText: 'Password',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenHeight *
                                                0.02), // 2% of screen height
                                        Center(
                                          child: SizedBox(
                                              width: screenWidth *
                                                  0.6, // 60% of screen width
                                              height: screenHeight *
                                                  0.07, // 7% of screen height
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
                                                        .circular(screenWidth *
                                                            0.07), // 7% of screen width
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: screenWidth *
                                                          0.05, // 5% of screen width
                                                      vertical: screenHeight *
                                                          0.02), // 2% of screen height
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
                                            height: screenHeight *
                                                0.02), // 2% of screen height
                                        const Center(
                                            child: Text(
                                          "Or sign in with",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Ballo 2",
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        )),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  width: screenWidth *
                                                      0.6, // 60% of screen width
                                                  height: screenHeight *
                                                      0.07, // 7% of screen height
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/image.png"),
                                                    onPressed: () {
                                                      appleAuth();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: screenWidth *
                                                      0.6, // 60% of screen width
                                                  height: screenHeight *
                                                      0.07, // 7% of screen height
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/image2.png"),
                                                    onPressed: () {
                                                      googleAuth();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth *
                                                    1, // 60% of screen width
                                                height: screenHeight *
                                                    0.05, // 7% of screen height
                                                child: TextButton(
                                                    onPressed: () {
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
                                                      style: TextStyle(
                                                        fontSize:
                                                            screenHeight * 0.02,
                                                        color: const Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontFamily: 'Ballo2',
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
