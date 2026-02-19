import "package:cravex/screens/signup.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class Forgotpassword extends StatefulWidget {
  @override
  State<Forgotpassword> createState() => _Forgotpassword();
}

class _Forgotpassword extends State<Forgotpassword> {
  final TextEditingController forgotpasscontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    forgotpasscontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color here instead of a Container height/width
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  "Password Recovery",
                  style: TextStyle(color: Colors.white, fontSize: 31),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Enter Your Email",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              SizedBox(height: 20),
              TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                controller: forgotpasscontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Added to prevent layout issues
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 5),
                      Text("Email", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    String email = forgotpasscontroller.text.trim();

                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("the email is empty")),
                      );
                      return;
                    }

                    try {
                      await _auth.sendPasswordResetEmail(email: email);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "If an account exists for this email, a reset link has been sent. Check inbox or spam.",
                          ),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case "invalid-email":
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "The email format is incorrect",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                          break;

                        case "user-not-found":
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "No user found with this email",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                          break;

                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Something went wrong",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                      }
                    }
                  },
                  child: Text(
                    "Send Email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signup()),
                      );
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.orange.shade300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              // Optional: Add bottom padding so content isn't flush against the keyboard
            ],
          ),
        ),
      ),
    );
  }
}
