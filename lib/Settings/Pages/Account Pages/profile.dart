import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/settings_service.dart';
import 'package:money_monkey/Settings/Widgets/custom_container.dart';

import '../../../Backend/Models/user_data.dart';
import '../../../Backend/Services/firestore_service.dart';
import '../../../themes/color_themes.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  UserData? userData;
  bool isLoading = true;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  String initName = "";
  String initUsername = "";
  String initEmail = "";
  String initPhone = "";

  void getUserInfo() async {
    try {
      userData = await firestoreService.getUserData(userID!);
      if (userData != null) {
        nameController.text = userData!.profile.fullName;
        usernameController.text = userData!.profile.username;
        emailController.text = userData!.email;
        phoneNumberController.text = userData!.phoneNumber;
        initName = userData!.profile.fullName;
        initUsername = userData!.profile.username;
        initEmail = userData!.email;
        initPhone = userData!.phoneNumber;
      } else {
        print("User data is null for userID: ${userID!}");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SettingsService settingsService = SettingsService();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FSettings%2Fno_pfp.png?alt=media&token=183f93b2-ae78-470f-9935-b04c14180bbe",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Change Image",
                              style: TextStyle(
                                color: LightTheme().primaryBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Name",
                        style: _sectionTitleStyle(),
                      ),
                      CustomContainer(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Username",
                        style: _sectionTitleStyle(),
                      ),
                      CustomContainer(
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Email",
                        style: _sectionTitleStyle(),
                      ),
                      CustomContainer(
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Phone Number",
                        style: _sectionTitleStyle(),
                      ),
                      CustomContainer(
                        child: TextField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (nameController.text != initName ||
                          emailController.text != initEmail ||
                          usernameController.text != initUsername ||
                          phoneNumberController.text != initPhone) ...[
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(2, 2),
                                  color: Colors.grey,
                                )
                              ]),
                          child: Center(
                            child: TextButton(
                              onPressed: () async {
                                await settingsService.updateProfileSettings(
                                  userId: userID!,
                                  name: nameController.text,
                                  username: usernameController.text,
                                  email: emailController.text,
                                  phoneNumber: phoneNumberController.text,
                                );
                                setState(() {
                                  initUsername = usernameController.text;
                                  initPhone = phoneNumberController.text;
                                  initEmail = emailController.text;
                                  initName = nameController.text;
                                });
                              },
                              child: Text(
                                "Save Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 245, 245, 245),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2, 2),
                                color: Colors.grey,
                              )
                            ]),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              _changePassword(context);
                            },
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 245, 245, 245),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2, 2),
                                color: Colors.grey,
                              )
                            ]),
                        child: Center(
                          child: Text(
                            "Delete Account",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _changePassword(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user == null) {
      print("No user is signed in.");
      return;
    }

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    // Show modal bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Current Password",
                  style: _sectionTitleStyle().copyWith(fontSize: 20),
                ),
                SizedBox(height: 16),
                CustomContainer(
                  child: TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "New Password",
                  style: _sectionTitleStyle().copyWith(fontSize: 20),
                ),
                SizedBox(height: 16),
                CustomContainer(
                  child: TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                      onPressed: () async {
                        final currentPassword = currentPasswordController.text;
                        final newPassword = newPasswordController.text;

                        try {
                          final credential = EmailAuthProvider.credential(
                            email: user.email!,
                            password: currentPassword,
                          );

                          await user.reauthenticateWithCredential(credential);

                          // Update password if re-authentication succeeds
                          await user.updatePassword(newPassword);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Password changed successfully')),
                          );
                        } catch (e) {
                          print("Password change failed: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Password change failed: $e')),
                          );
                        }
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
