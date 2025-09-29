import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';

import '../../../themes/color_themes.dart';

class SUDetailsUsernamePage extends GetView<SignUpController> {
  SUDetailsUsernamePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SUDetailsUsernamePageView();
  }
}

class _SUDetailsUsernamePageView extends StatefulWidget {
  @override
  State<_SUDetailsUsernamePageView> createState() => _SUDetailsUsernamePageViewState();
}

class _SUDetailsUsernamePageViewState extends State<_SUDetailsUsernamePageView> {
  final TextEditingController usernameController = TextEditingController();
  
  late final SignUpController signUpController = Get.find();

  @override
  void initState() {
    super.initState();
    // Sync the text controller with the stored value when page loads
    usernameController.text = signUpController.username.value;
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void submitUsername(String val) {
    signUpController.username.value = val;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 200, // Account for app bar and button space
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // Header Section
              _buildHeader(),
              
              const SizedBox(height: 48),
              
              // Username Input Section
              _buildUsernameInput(),
              
              const SizedBox(height: 16),
              
              // Helper Text
              _buildHelperText(),
              
              const SizedBox(height: 100), // Space for floating action button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Username Icon
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
            Icons.alternate_email,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        const Text(
          "Choose a username",
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
          "This is how others will find you",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildUsernameInput() {
    return Obx(() {
      final hasUsername = signUpController.username.value.isNotEmpty;
      
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasUsername ? Theme.of(context).primaryColor : Colors.grey[300]!,
            width: hasUsername ? 2 : 1,
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
          controller: usernameController,
          onChanged: (value) {
            submitUsername(value.trim().toLowerCase()); // Trim and lowercase for usernames
          },
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your username",
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            prefixIcon: Icon(
              Icons.alternate_email,
              color: hasUsername ? Theme.of(context).primaryColor : Colors.grey[400],
            ),
            suffixIcon: hasUsername ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 20,
            ) : null,
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
            submitUsername(value.trim().toLowerCase());
          },
        ),
      );
    });
  }

  Widget _buildHelperText() {
    return Obx(() {
      final username = signUpController.username.value;
      
      return Column(
        children: [
          if (username.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your username will be: @$username",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Choose something unique and memorable",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      );
    });
  }
}