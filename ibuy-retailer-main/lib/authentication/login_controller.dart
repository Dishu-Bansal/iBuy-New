import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(String email, String password) {
    //authenticate user with firebase auth
    //navigate to home page

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //navigate to home page
      //display a snackbar with success message
      Get.snackbar("Success", "Login successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.offAll(() => const HomePage());
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }
}
