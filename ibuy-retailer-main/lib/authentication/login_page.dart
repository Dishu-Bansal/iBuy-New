import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/authentication/request_access_page.dart';

import '../constants.dart';
import '../widgets/side_bg_widget.dart';
import 'login_controller.dart';

final formKey = GlobalKey<FormState>();
final loginController = Get.put(LoginController());
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

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
                    Center(child: Image.asset("logo.png")),
                    const SizedBox(height: 100),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
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
                    PasswordField(),
                    const SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          loginController.login(
                              loginController.emailController.text,
                              loginController.passwordController.text);
                        } else {
                          //display error message with snackbar
                          Get.snackbar("Error", "Please fill all the fields",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              isDismissible: true,
                              duration: Duration(seconds: 15));
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "New User?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(const RequestAccessPage());
                          },
                          child: const Text(
                            "Register Here",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginController.passwordController,
      obscureText: _obscureText,
      cursorColor: Colors.black45,
      decoration: InputDecoration(
        labelText: "Enter your Password",
        //border: OutlineInputBorder(),
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,),
          onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          },),
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
    );
  }
}

