import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';

import '../../../themes/color_themes.dart';

class SUDetailsNamePage extends GetView<SignUpController> {
  SUDetailsNamePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SUDetailsNamePageView();
  }
}

class _SUDetailsNamePageView extends StatefulWidget {
  @override
  State<_SUDetailsNamePageView> createState() => _SUDetailsNamePageViewState();
}

class _SUDetailsNamePageViewState extends State<_SUDetailsNamePageView> {
  final TextEditingController nameController = TextEditingController();
  
  late final SignUpController signUpController = Get.find();

  @override
  void initState() {
    super.initState();
    // Sync the text controller with the stored value when page loads
    nameController.text = signUpController.name.value;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submitName(String val) {
    signUpController.name.value = val;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 60),
          
          // Header Section
          _buildHeader(),
          
          const SizedBox(height: 48),
          
          // Name Input Section
          _buildNameInput(),
          
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Welcome Icon
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
            Icons.waving_hand,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Title
        const Text(
          "What's your name?",
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
          "Let's get to know you better",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameInput() {
    return Container(
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
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          submitName(value);
        },
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your full name",
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),
          prefixIcon: Icon(
            Icons.person_outline,
            color: Colors.grey[400],
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
          submitName(value);
        },
      ),
    );
  }
}