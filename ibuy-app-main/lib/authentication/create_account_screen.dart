import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/authentication/forgot_password_screen.dart';
import 'package:freelance_ibuy_app/authentication/input_user_details.dart';
import 'package:freelance_ibuy_app/screens/plan_status_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

import '../utils.dart';

class CreateAccountScreen extends StatefulWidget {
  static String email = "";
  static String pass = "";
  // static bool isEmailUser = false;
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // static bool isEmailUser = false;

  var isLoading = false;

  var email = "";

  //This will validate the inputs
  bool validateInputs() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void signIn(BuildContext context) {
    if (validateInputs()) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.toString().trim(),
              password: passwordController.text.toString().trim())
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlanStatusScreen(),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Invalid email or password!",
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      });

      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Input all the fields!",
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future signUp(BuildContext context) async {
    if (validateInputs()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.toString().trim(),
            password: passwordController.text.toString().trim());

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.toString().trim(),
            password: passwordController.text.toString().trim());

        CreateAccountScreen.email = emailController.text.toString().trim();
        CreateAccountScreen.pass = passwordController.text.toString().trim();

        setState(() {
          isLoading = false;
        });
        if (!mounted) {}
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return InputUserDetails(
              email: CreateAccountScreen.email,
              password: CreateAccountScreen.pass,
            );
          }),
        );
      } on FirebaseAuthException catch (a) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              a.message.toString(),
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Input all the fields!",
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color(0xffFEC107),
              ))
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(child: Image.asset("assets/Group 131.png")),
                        const Text(
                          "Create New Account",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  cursorColor: Colors.black45,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.black45,
                                    ),
                                    labelText: "Enter your Email ID",
                                    //border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        const TextStyle(color: Colors.black45),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
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
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    labelText: "Enter your Password",
                                    //border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        const TextStyle(color: Colors.black45),

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
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    signUp(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFEC107),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: const Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () => signIn(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: const Center(
                                      child: Text(
                                        "SIGN IN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        AppRoutes.push(context,
                                            const ForgotPasswordScreen());
                                        // await _displayTextInputDialog(context);
                                        // //display a toast with success message
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(const SnackBar(
                                        //         content: Text(
                                        //             'Password reset link sent to your email')));
                                        // Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Forgot Password?",
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Utils().signInWithGoogle(context);
                                    //if (!mounted) return;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF4F4F4),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: const Center(
                                      child: Text(
                                        "SIGN IN WITH GOOGLE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
