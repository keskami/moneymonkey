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
                        child: SingleChildScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => _onButtonPressed(0),
                                      child: const Text(
                                        "Create Account",
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 22,
                                            fontFamily: 'Ballo2'),
                                      ),
                                    ),
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
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _selectedIndex == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Create Account',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontFamily: 'Ballo2'),
                                            textAlign: TextAlign.left,
                                          ),
                                          const Text(
                                            'Let’s get started by filling out the form below.',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontFamily: 'Ballo2'),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Email',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Password',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Confirm Password',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Center(
                                            child: SizedBox(
                                                width: 220,
                                                height: 49,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    print("clicked");
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            135, 206, 235, 1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
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
                                          const SizedBox(height: 15),
                                          const Center(
                                              child: Text(
                                            "Or sign up with",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Ballo 2",
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1)),
                                          )),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 220,
                                                  height: 50,
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/image.png"),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  height: 50,
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
                                      )
                                    :  Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Create Account',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontFamily: 'Ballo2'),
                                            textAlign: TextAlign.left,
                                          ),
                                          const Text(
                                            'Let’s get started by filling out the form below.',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontFamily: 'Ballo2'),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Email',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Password',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 314,
                                            height: 49,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                labelText: 'Confirm Password',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Center(
                                            child: SizedBox(
                                                width: 220,
                                                height: 49,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    print("clicked");
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            135, 206, 235, 1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
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
                                          const SizedBox(height: 15),
                                          const Center(
                                              child: Text(
                                            "Or sign up with",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Ballo 2",
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 1)),
                                          )),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 220,
                                                  height: 50,
                                                  child: IconButton(
                                                    icon: Image.asset(
                                                        "assets/images/image.png"),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                  height: 50,
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
                                      )
                              ],
                            ),
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
