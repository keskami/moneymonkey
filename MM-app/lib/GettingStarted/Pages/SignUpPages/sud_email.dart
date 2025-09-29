import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Widgets/sign_in_button.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/home.dart';

class SUDetailsEmailPage extends GetView<SignUpController> {
  const SUDetailsEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _SUDetailsEmailPageView();
  }
}

class _SUDetailsEmailPageView extends StatefulWidget {
  @override
  State<_SUDetailsEmailPageView> createState() => _SUDetailsEmailPageViewState();
}

class _SUDetailsEmailPageViewState extends State<_SUDetailsEmailPageView> {
  final TextEditingController emailController = TextEditingController();
  final AuthService authService = AuthService();
  
  late final SignUpController signUpController = Get.find();

  @override
  void initState() {
    super.initState();
    // Sync the text controller with the stored value when page loads
    emailController.text = signUpController.email.value;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> submitEmail(String val) async {
    signUpController.email.value = val;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // Header Section
                _buildHeader(),
                
                const SizedBox(height: 48),
                
                // Email Input Section
                _buildEmailInput(),
                
                const SizedBox(height: 40),
                
                // Divider
                _buildDivider(),
                
                const SizedBox(height: 32),
                
                // Social Sign In Section
                Expanded(
                  child: _buildSocialSignInSection(context, screenWidth),
                ),
              ],
            ),
          ),
          if (signUpController.isLoading.value)
            Container(
              color: Colors.grey.withOpacity(0.5),
              height: screenHeight,
              width: screenWidth,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // User Avatar or Icon
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Icon(
            Icons.person,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        Text(
          "What's your email, ${signUpController.name.value}?",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 12),
        
        // Subtitle
        Text(
          "We'll use this to create your account",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailInput() {
    return Obx(() {
      final email = signUpController.email.value;
      final hasValidEmail = email.trim().isNotEmpty && email.isEmail;
      final hasText = email.trim().isNotEmpty;
      
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasValidEmail 
                ? Theme.of(context).primaryColor 
                : (hasText && !email.isEmail)
                    ? Colors.red
                    : Colors.grey[300]!,
            width: hasValidEmail || (hasText && !email.isEmail) ? 2 : 1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: emailController,
          onChanged: (value) {
            submitEmail(value.trim());
          },
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your email address",
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: hasValidEmail 
                  ? Theme.of(context).primaryColor 
                  : (hasText && !email.isEmail)
                      ? Colors.red
                      : Colors.grey[400],
            ),
            suffixIcon: hasValidEmail 
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  )
                : (hasText && !email.isEmail)
                    ? Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 20,
                      )
                    : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          onSubmitted: (value) {
            submitEmail(value.trim());
          },
        ),
      );
    });
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Or continue with",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSignInSection(BuildContext context, double screenWidth) {
    return Column(
      children: [
        _buildGoogleSignInButton(context),
        const SizedBox(height: 12),
        _buildAppleSignInButton(),
        const Spacer(),
      ],
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            await authService.googleAuth(context);
            Get.offAll(
              () => HomePage(),
              predicate: (route) => false,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fgoogle_logo.png?alt=media&token=b1cc9b7e-785b-4af5-9e37-9af74d69eeb9",
                height: 24,
                width: 24,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.login,
                  size: 24,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Continue with Google",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacebookSignInButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Implement Facebook sign in
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Ffacebook_logo.png?alt=media&token=a1810c16-71d9-4537-9201-6d7c47d22577",
                height: 24,
                width: 24,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.facebook,
                  size: 24,
                  color: Colors.blue[600],
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Continue with Facebook",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppleSignInButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Implement Apple sign in
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fapple_logo.png?alt=media&token=151b1835-0e40-4bf7-b6d2-61dc70de963b",
                height: 24,
                width: 24,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.apple,
                  size: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Continue with Apple",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}