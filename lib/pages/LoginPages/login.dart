// ignore_for_file: prefer_final_fields
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_monkey/Pages/ProfilePages/profileScreen.dart';

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
        } else if (e.code == 'newtwork-request-failed') {
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

  Future<void> addUserDetails(String userId, String email) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(userId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      return;
    }

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
        if (!mounted) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfileScreen(),
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
                const SizedBox(height: 19),
                SizedBox(
                  height: 1144,
                  width: 390,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      const SizedBox(height: 19),
                      Image.asset(
                        'assets/images/monkey.png',
                        height: 390,
                        width: 390,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        top: 210,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(13, 16, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(.5),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10.0,
                                spreadRadius: 3.0,
                                offset: Offset(
                                    0, 4), // Changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(26, 22, 0, 0),
                                    child: Text(
                                      'Welcome Back',
                                      style: GoogleFonts.baloo2(
                                        fontSize: 26,
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(26, 9, 0, 0),
                                    child: Text(
                                      'Fill out the information below in order',
                                      style: GoogleFonts.baloo2(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(26, 2, 0, 0),
                                    child: Text(
                                      'to access your account.',
                                      style: GoogleFonts.baloo2(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(28, 29, 0, 0),
                                    child: SizedBox(
                                      width: 314,
                                      height: 49,
                                      child: TextField(
                                        controller: _loginEmailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          labelText: 'Email',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(29, 9, 0, 0),
                                    child: SizedBox(
                                      width: 314,
                                      height: 49,
                                      child: TextField(
                                        controller: _loginPasswordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 13),
                                  Center(
                                    child: SizedBox(
                                        width: 220,
                                        height: 49,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            logIn();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    135, 206, 235, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
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
                                  const SizedBox(height: 30),
                                  Center(
                                      child: Text(
                                    "Or sign in with",
                                    style: GoogleFonts.baloo2(
                                        fontSize: 14,
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 1)),
                                  )),
                                  const SizedBox(height: 19),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Center(
                                          child: IconButton(
                                            icon: Image.asset(
                                              "assets/images/apple.png",
                                              height: 34,
                                              width: 220,
                                            ),
                                            onPressed: () {
                                              appleAuth();
                                            },
                                          ),
                                        ),
                                        Center(
                                          child: IconButton(
                                            icon: Image.asset(
                                              "assets/images/google.png",
                                              height: 34,
                                              width: 220,
                                            ),
                                            onPressed: () {
                                              googleAuth();
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 19, 0, 0),
                                          child: Center(
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
                                                    fontSize: 14,
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                )),
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
