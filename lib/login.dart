import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Index for create or login
  int _selectedIndex = 0;
  // Switches Screen
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 744,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        'assets/images/monkey.png',
                        height: 390,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        top: 195,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () => _onButtonPressed(0),
                                    child: const Text("Create Account",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,

                                    ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => _onButtonPressed(1),
                                    child: const Text("Log in",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20), 
                              _selectedIndex == 0
                                  ? const Text('Create Account',
                                      style: TextStyle(fontSize: 24))
                                  : const Text('Log in',
                                      style: TextStyle(fontSize: 24)),
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
