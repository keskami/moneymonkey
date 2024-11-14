// ignore_for_file: prefer_final_fields
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/gs_home.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/home.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/friendsPages/friendsHome.dart';

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
    List<String> following = [
      "QofNULUkjTRKL0cQccTNrwuri5I3",
      '7dj9N77S66anoMSzGc442iItH2u1',
    ];

    List<String> followers = [
      "QofNULUkjTRKL0cQccTNrwuri5I3",
      'J5OHmCH5dAgTtqgBtC9qHUSj34L2',
      '6mMH88Ebp4aiYWIT3jGfBDyxxRB2'
    ];

    await userDocRef.set({
      'User ID': userId,
      'Email': email,
      'Age': 0,
      'Knowledge Level': 0,
      'Learning Goal Per Day': 0,
      'Profile': {
        'Full Name': 'Your Name Here',
        'Username': 'Your Name Here',
        'Number of Followers': 3,
        'Following': 2,
        'Top Achievements': 0,
        'Streak': 0,
        'Total Profit': 0,
        'Average Monthly Growth': 0,
      },
      'Portfolio': {
        'Total Bananas': 8976,
        'Balance': 908,
        'Weekly net gain': -90,
      },
      'Invest Page (Discover)': {
        'Total Invested (Stocks)': 100,
        'Total Profit (Stocks)': 50,
        'Total Invested (ETFs)': 300,
        'Total Profit (ETFs)': -50,
        'Total Invested (Mutual Funds)': 500,
        'Total Profit (Mutual Funds)': 600,
        'Total Invested (Bonds)': 234,
        'Total Profit (Bonds)': -10,
        'Total invested Bananas': 7089,
        'Profit from Invested Bananas (Current Month)': 890,
        'Username': "Josh5"
      },
      'following': following,
      'followers': followers,
    });

    final transactionsRef = userDocRef.collection('Transactions');

    await transactionsRef.add(
      {
        'Source/Destination': 'Test Source',
        'Amount': 200,
        'Date': FieldValue.serverTimestamp(),
        'Type': "Income"
      },
    );
    await transactionsRef.add({
      'Source/Destination': 'Test Source 2',
      'Amount': 150,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Income"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Expense Source 1',
      'Amount': -100,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Expense"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Expense Source 2',
      'Amount': -50,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Expense"
    });

    await transactionsRef.add({
      'Source/Destination': 'Test Source 3',
      'Amount': 300,
      'Date': FieldValue.serverTimestamp(),
      'Type': "Income"
    });
  }

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
      if (userId.isNotEmpty) {
        if (!mounted) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendsHome(),
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

  Future<void> googleAuth(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();

    googleUser ??= await GoogleSignIn().signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String userId = userCredential.user?.uid ?? '';
      String email = userCredential.user?.email ?? '';
      if (userId.isNotEmpty) {
        final userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);
        final userSnapshot = await userDocRef.get();

        if (!userSnapshot.exists) {
          await addUserDetails(userId, email);
        } else {}

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendsHome(),
          ),
        );
      }
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
    double screenWidthUnit = MediaQuery.of(context).size.width / 400;
    double screenHeightUnit = MediaQuery.of(context).size.height / 880;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: screenWidthUnit * double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeightUnit * 19),
                SizedBox(
                  height: screenHeightUnit * 1144,
                  width: screenWidthUnit * 390,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(height: screenHeightUnit * 19),
                      Image.asset(
                        'assets/images/monkey.png',
                        height: screenHeightUnit * 390,
                        width: screenWidthUnit * 390,
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
                              width: screenWidthUnit * 3,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10.0,
                                spreadRadius: 3.0,
                                offset: const Offset(0, 4),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(26, 16, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(26, 9, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(26, 2, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(28, 29, 0, 0),
                                    child: SizedBox(
                                      width: screenWidthUnit * 314,
                                      height: screenHeightUnit * 49,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(29, 9, 0, 0),
                                    child: SizedBox(
                                      width: screenWidthUnit * 314,
                                      height: screenHeightUnit * 49,
                                      child: TextField(
                                        obscureText: true,
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
                                  SizedBox(height: screenHeightUnit * 13),
                                  Center(
                                    child: SizedBox(
                                        width: screenWidthUnit * 220,
                                        height: screenHeightUnit * 49,
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
                                  SizedBox(height: screenHeightUnit * 30),
                                  Center(
                                      child: Text(
                                    "Or sign in with",
                                    style: GoogleFonts.baloo2(
                                        fontSize: 14,
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 1)),
                                  )),
                                  SizedBox(height: screenHeightUnit * 19),
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
                                              height: screenHeightUnit * 34,
                                              width: screenWidthUnit * 220,
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
                                              height: screenHeightUnit * 34,
                                              width: screenWidthUnit * 220,
                                            ),
                                            onPressed: () {
                                              googleAuth(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 19, 0, 0),
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
                                                          GettingStartedHome(),
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
