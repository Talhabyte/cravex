import 'package:cravex/screens/bottomvav.dart';

import 'package:flutter/material.dart';
import 'package:cravex/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFFff5c30),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 220,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            top: 60,
            child: Image.asset(
              "assets/Images/cravex.jpg",
              width: 100,
              height: 80,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 140,
            child: SingleChildScrollView(
              child: Card(
                color: Colors.white,
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10),
                              Text(
                                "Name",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFff5c30),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.email_outlined),
                              SizedBox(width: 10),
                              Text(
                                "Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFff5c30),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.password),
                              SizedBox(width: 10),
                              Text(
                                "Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFff5c30),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFFff5c30),
                          ),
                          onPressed: () async {
                            String name = namecontroller.text.trim();
                            String email = emailcontroller.text.trim();
                            String password = passcontroller.text.trim();
                            if (name.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "Please fill all information",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              );
                              return;
                            }
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              // Optional: update display name
                              await _auth.currentUser!.updateDisplayName(name);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("User added successfully"),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => login(),
                                ),
                              );
                            } on FirebaseException catch (e) {
                              if (e.code == "weak-password") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Password is too weak",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              } else if (e.code == "email-already-in-use") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "User Already Exists",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              } else if (e.code == "network-request-failed") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Please check your internet connection",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              } else if (e.code == "invalid-email") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "The email format is incorrect",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      e.message ?? "Signup failed",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                );
                              }
                            }
                          },

                          child: Text("SIGN UP"),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
