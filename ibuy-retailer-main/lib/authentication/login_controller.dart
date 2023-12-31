import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    //authenticate user with firebase auth
    //navigate to home page

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("retailers")
          .doc(value.user!.uid)
          .get()
          .then((value) async {
        if (value.data()?["status"] == true) {
          //navigate to home page
          //display a snackbar with success message
          Get.snackbar(
            "Success",
            "Login successful",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            isDismissible: true,
          );
          Get.offAll(() => const HomePage());
        } else {
          Get.snackbar("Approval Pending",
              "Your account is pending for approval by iBuy Admin. It may take up to 24 hours before your account is activated. Please contact xxx@ibuy.com in case you have any questions.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              isDismissible: true,
              duration: Duration(seconds: 15));
          await FirebaseAuth.instance.signOut();
        }
      });
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          duration: Duration(seconds: 15));
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true,
          duration: Duration(seconds: 15));
    });
  }
}
