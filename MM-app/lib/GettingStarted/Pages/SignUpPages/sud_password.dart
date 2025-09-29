import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';

import '../../../themes/color_themes.dart';

class SUDetailsPasswordPage extends GetView<SignUpController> {
  SUDetailsPasswordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SUDetailsPasswordPageView();
  }
}

class _SUDetailsPasswordPageView extends StatefulWidget {
  @override
  State<_SUDetailsPasswordPageView> createState() => _SUDetailsPasswordPageViewState();
}

class _SUDetailsPasswordPageViewState extends State<_SUDetailsPasswordPageView> {
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  
  late final SignUpController signUpController = Get.find();

  @override
  void initState() {
    super.initState();
    // Sync the text controller with the stored value when page loads
    passwordController.text = signUpController.password.value;
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> submitPassword(String val) async {
    signUpController.password.value = val;
  }

  // Password strength checker
  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '';
    if (password.length < 6) return 'Too short';
    if (password.length < 8) return 'Weak';
    
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    int score = 0;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasDigits) score++;
    if (hasSpecialCharacters) score++;
    
    if (score <= 1) return 'Weak';
    if (score <= 2) return 'Fair';
    if (score <= 3) return 'Good';
    return 'Strong';
  }

  Color _getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'Too short':
        return Colors.red;
      case 'Weak':
        return Colors.orange;
      case 'Fair':
        return Colors.yellow[700]!;
      case 'Good':
        return Colors.lightGreen;
      case 'Strong':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 200,
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // Header Section
              _buildHeader(),
              
              const SizedBox(height: 48),
              
              // Password Input Section
              _buildPasswordInput(),
              
              const SizedBox(height: 16),
              
              // Password Requirements
              _buildPasswordRequirements(),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Security Icon
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
            Icons.lock_outline,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        const Text(
          "Create a password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 12),
        
        // Subtitle
        Text(
          "Keep your account secure",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Obx(() {
      final password = signUpController.password.value;
      final isValidPassword = password.isNotEmpty && password.length >= 6;
      final strength = _getPasswordStrength(password);
      
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isValidPassword 
                ? _getPasswordStrengthColor(strength)
                : password.isNotEmpty 
                    ? Colors.red
                    : Colors.grey[300]!,
            width: isValidPassword || password.isNotEmpty ? 2 : 1,
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
          controller: passwordController,
          onChanged: (value) {
            submitPassword(value);
          },
          autofocus: true,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your password",
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: isValidPassword 
                  ? _getPasswordStrengthColor(strength)
                  : password.isNotEmpty 
                      ? Colors.red
                      : Colors.grey[400],
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isValidPassword) 
                  Icon(
                    Icons.check_circle,
                    color: _getPasswordStrengthColor(strength),
                    size: 20,
                  ),
                IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ],
            ),
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
            submitPassword(value);
          },
        ),
      );
    });
  }

  Widget _buildPasswordRequirements() {
    return Obx(() {
      final password = signUpController.password.value;
      final strength = _getPasswordStrength(password);
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (password.isNotEmpty) ...[
            // Password strength indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _getPasswordStrengthColor(strength).withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Icon(
                    strength == 'Strong' ? Icons.shield : Icons.info_outline,
                    size: 16,
                    color: _getPasswordStrengthColor(strength),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Password strength: $strength",
                    style: TextStyle(
                      fontSize: 14,
                      color: _getPasswordStrengthColor(strength),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Requirements list
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password must contain:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                _buildRequirement("At least 6 characters", password.length >= 6),
                _buildRequirement("One uppercase letter", password.contains(RegExp(r'[A-Z]'))),
                _buildRequirement("One lowercase letter", password.contains(RegExp(r'[a-z]'))),
                _buildRequirement("One number", password.contains(RegExp(r'[0-9]'))),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? Colors.green : Colors.grey[400],
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isMet ? Colors.green : Colors.grey[600],
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}