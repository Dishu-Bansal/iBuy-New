import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ibuy_admin_app/home_page.dart';

import '../../constants.dart';
import '../../widgets/side_bg_widget.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Row(
        children: [
          const SideWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "admin_logo.png",
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 70),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Hi, Welcome back!",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: loginController.emailController,
                      cursorColor: Colors.black45,
                      decoration: InputDecoration(
                        labelText: "Enter your Email ID",
                        //border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.black45),

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
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: loginController.passwordController,
                      cursorColor: Colors.black45,
                      decoration: InputDecoration(
                        labelText: "Enter your Password",
                        //border: OutlineInputBorder(),

                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.black45),

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
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.to(const HomePage());
                        if (formKey.currentState!.validate()) {
                          if (loginController.login()) {
                            Get.to(const HomePage());
                          } else {
                            //display error message with snackbar
                            Get.snackbar("Error", "Invalid Credentials",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        } else {
                          //display error message with snackbar
                          Get.snackbar("Error", "Please fill all the fields",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                          //Get.to(const HomePage());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Text("Forgot password?  /  Don't have an account?"),
                    const Spacer(),
                    const Center(child: Text("iBuy Team | 2022"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
