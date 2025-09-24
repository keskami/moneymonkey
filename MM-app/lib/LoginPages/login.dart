// ignore_for_file: prefer_final_fields
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Pages/gs_home.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Services
  final AuthService _authService = AuthService();
  
  // Loading state
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handles user login
  Future<void> _handleLogin() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Please fill in both email and password.", Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    final success = await _authService.signInUser(
      _emailController.text.trim(),
      _passwordController.text,
      context,
    );

    setState(() => _isLoading = false);

    // Success navigation is handled in AuthService
    if (!success) {
      // Error messages are handled in AuthService
    }
  }

  /// Handles Google sign-in
  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    
    final success = await _authService.googleAuth(context);
    
    setState(() => _isLoading = false);
    
    // Success navigation is handled in AuthService
    if (!success) {
      // Error messages are handled in AuthService
    }
  }

  /// Handles Apple sign-in
  Future<void> _handleAppleSignIn() async {
    setState(() => _isLoading = true);
    
    try {
      final appleProvider = AppleAuthProvider();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(appleProvider);
      
      String userId = userCredential.user!.uid;
      String email = userCredential.user?.email ?? "";
      
      if (email.isNotEmpty) {
        // This will create user profile if it doesn't exist
        await _authService.googleAuth(context); // Reuse the Google auth logic
      } else {
        _showSnackBar("Unable to get email from Apple account.", Colors.red);
      }
    } catch (e) {
      _showSnackBar("Error during Apple Sign In: $e", Colors.red);
    }
    
    setState(() => _isLoading = false);
  }

  /// Navigates to sign up screen
  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GettingStartedHome()),
    );
  }

  /// Shows a snackbar message
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
      ),
    );
  }

  /// Builds the landscape layout
  Widget _buildLandscapeLayout() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 400;
    double screenHeightUnit = screenHeight / 880;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Sign Up button in top right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  screenHeightUnit * 25,
                  screenWidthUnit * 30,
                  0,
                ),
                child: TextButton(
                  onPressed: _navigateToSignUp,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(135, 206, 235, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.grey.withOpacity(0.3),
                    elevation: 3,
                  ),
                  child: Container(
                    width: screenWidthUnit * 40,
                    height: screenHeightUnit * 50,
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.baloo2(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Main content
          SizedBox(
            height: screenHeightUnit * 794,
            width: screenWidthUnit * 100,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Monkey image
                Image.asset(
                  'assets/images/monkey.png',
                  height: screenHeightUnit * 390,
                  width: screenWidthUnit * 390,
                  alignment: Alignment.topCenter,
                ),
                // Login form
                Positioned(
                  top: 205 * screenHeightUnit,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildLoginForm(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the portrait layout
  Widget _buildPortraitLayout() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeightUnit * 19),
          SizedBox(
            height: screenHeightUnit * 1144,
            width: screenWidthUnit * 390,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Monkey image
                Image.asset(
                  'assets/images/monkey.png',
                  height: screenHeightUnit * 390,
                  width: screenWidthUnit * 390,
                  alignment: Alignment.topCenter,
                ),
                // Login form
                Positioned(
                  top: 210,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildLoginForm(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the login form container
  Widget _buildLoginForm(bool isLandscape) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / (isLandscape ? 400 : 390);
    double screenHeightUnit = screenHeight / 880;

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 16, 13, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(.5),
          width: isLandscape ? 0 : screenWidthUnit * 3,
        ),
        borderRadius: BorderRadius.circular(isLandscape ? 10 : 30),
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
          SizedBox(height: isLandscape ? screenHeightUnit * 25 : 16),
          _buildWelcomeText(isLandscape, screenHeightUnit),
          _buildInputFields(isLandscape, screenWidthUnit, screenHeightUnit),
          _buildLoginButton(isLandscape, screenWidthUnit, screenHeightUnit),
          _buildSocialSignIn(isLandscape, screenWidthUnit, screenHeightUnit),
          if (!isLandscape) _buildSignUpPrompt(),
        ],
      ),
    );
  }

  /// Builds the welcome text section
  Widget _buildWelcomeText(bool isLandscape, double screenHeightUnit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(26, isLandscape ? 1 * screenHeightUnit : 16, 0, 0),
          child: Text(
            'Welcome Back',
            style: GoogleFonts.baloo2(
              fontSize: isLandscape ? 30 * screenHeightUnit : 26,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 9, 0, 0),
          child: Text(
            'Fill out the information below in order',
            style: GoogleFonts.baloo2(
              fontSize: isLandscape ? 16 * screenHeightUnit : 14,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(26, isLandscape ? 2 * screenHeightUnit : 2, 0, 0),
          child: Text(
            'to access your account.',
            style: GoogleFonts.baloo2(
              fontSize: isLandscape ? 16 * screenHeightUnit : 14,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the input fields section
  Widget _buildInputFields(bool isLandscape, double screenWidthUnit, double screenHeightUnit) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            isLandscape ? 15 * screenHeightUnit : 15,
            isLandscape ? 10 * screenHeightUnit : 29,
            isLandscape ? 15 * screenHeightUnit : 15,
            0,
          ),
          child: SizedBox(
            width: isLandscape ? screenWidthUnit * 150 : screenWidthUnit * 314,
            height: screenHeightUnit * 49,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            isLandscape ? 15 * screenHeightUnit : 15,
            isLandscape ? 12 * screenHeightUnit : 9,
            isLandscape ? 15 * screenHeightUnit : 15,
            0,
          ),
          child: SizedBox(
            width: isLandscape ? screenWidthUnit * 150 : screenWidthUnit * 314,
            height: screenHeightUnit * 49,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the login button
  Widget _buildLoginButton(bool isLandscape, double screenWidthUnit, double screenHeightUnit) {
    return Column(
      children: [
        SizedBox(height: screenHeightUnit * 13),
        Center(
          child: SizedBox(
            width: isLandscape ? screenWidthUnit * 75 : screenWidthUnit * 220,
            height: screenHeightUnit * 49,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(135, 206, 235, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 18 * screenHeightUnit : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the social sign-in section
  Widget _buildSocialSignIn(bool isLandscape, double screenWidthUnit, double screenHeightUnit) {
    return Column(
      children: [
        SizedBox(height: isLandscape ? screenHeightUnit * 20 : screenHeightUnit * 30),
        Center(
          child: Text(
            "Or sign in with",
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
        SizedBox(height: screenHeightUnit * 19),
        Center(
          child: Column(
            children: [
              // Apple Sign In
              IconButton(
                icon: Image.asset(
                  "assets/images/apple.png",
                  height: screenHeightUnit * 34,
                  width: isLandscape ? screenWidthUnit * 75 : screenWidthUnit * 220,
                ),
                onPressed: _isLoading ? null : _handleAppleSignIn,
              ),
              // Google Sign In
              IconButton(
                icon: Image.asset(
                  "assets/images/google.png",
                  height: screenHeightUnit * 34,
                  width: isLandscape ? screenWidthUnit * 75 : screenWidthUnit * 220,
                ),
                onPressed: _isLoading ? null : _handleGoogleSignIn,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the sign-up prompt (portrait only)
  Widget _buildSignUpPrompt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
      child: Center(
        child: TextButton(
          onPressed: _navigateToSignUp,
          child: Text(
            "If you are new, create a new account here",
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: const Color.fromRGBO(0, 0, 0, 1),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}