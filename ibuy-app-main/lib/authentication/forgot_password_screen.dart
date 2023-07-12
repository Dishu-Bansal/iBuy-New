import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  var isLoading = false;
  void resetPass(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.toString().trim())
          .then((value) => null)
          .catchError((onError) {
        //display error message
        setState(() {
          isLoading = false;
        });
        //show snack bar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Task failed: $onError"),
          ),
        );
      });

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Password reset link has been sent to your email. Check your spam Folder.'),
        ),
      );

      //Create a timer for 2 sec
      Timer(const Duration(seconds: 5), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: goldColor,
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  obscureText: false,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    labelText: "Enter your Email",
                    //border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black45),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      borderSide: const BorderSide(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 200,
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: goldColor,
                      )
                    : InkWell(
                        onTap: () => resetPass(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFEC107),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "Request Reset Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ),
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
