import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/nothing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> createNewUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _createEmailController.text,
        password: _createPasswordController.text,
      );

      String userId = userCredential.user!.uid;
      addUserDetails(userId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUserDetails(String userId) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);

    //
    await userDocRef.set({
      'User ID': userId,
      'Email': _createEmailController.text.trim(),
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

  Future logIn() async {
   
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );
       String userId = userCredential.user?.uid ?? '';

      if (userId.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserIdScreen(),
          ),
        );
      } 

    
  }

  // Index for create or login
  int _selectedIndex = 0;
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

  // Switches Screen
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () => _onButtonPressed(0),
                                        child: const Text(
                                          "Create Account",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 22,
                                            fontFamily: 'Ballo2',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: screenWidth *
                                            0.4, // 40% of screen width
                                        color: _selectedIndex == 0
                                            ? Color.fromRGBO(75, 57, 239, 1)
                                            : Colors.white,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () => _onButtonPressed(1),
                                        child: const Text(
                                          "Log in",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 22,
                                            fontFamily: 'Ballo2',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 2,
                                        width: screenWidth *
                                            0.3, // 30% of screen width
                                        color: _selectedIndex == 1
                                            ? Color.fromRGBO(75, 57, 239, 1)
                                            : Colors.white,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: screenHeight *
                                      0.025), // 3% of screen height
                              _selectedIndex == 0
                                  ? SingleChildScrollView(
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create Account',
                                          style: TextStyle(
                                              fontSize:
                                                  22, // 3% of screen height
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          'Let’s get started by filling out the form below.',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.02, // 2% of screen height
                                              color: Color.fromRGBO(0, 0, 0, 1),
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
                                                  print("here");
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
                                                  onPressed: () {},
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
                                                  onPressed: () {},
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
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Ballo2'),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          'Log in with your credentials.',
                                          style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.02, // 2% of screen height
                                              color: Color.fromRGBO(0, 0, 0, 1),
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
                                                  print("clicked Login");
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
                                              SizedBox(
                                                width: screenWidth *
                                                    0.6, // 60% of screen width
                                                height: screenHeight *
                                                    0.07, // 7% of screen height
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      "assets/images/image.png"),
                                                  onPressed: () {},
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
                                                  onPressed: () {},
                                                ),
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
