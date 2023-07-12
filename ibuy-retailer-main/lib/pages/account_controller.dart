import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authentication/login_page.dart';

class AccountActivationController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void createAndStoreAccount(String email, String password) {
    //authenticate user with firebase auth
    //store user details in firestore
    //navigate to login page
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //store user details in firestore
      FirebaseFirestore.instance
          .collection("retailers")
          .doc(value.user!.uid)
          .set({
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": email,
        "password": password,
        "uid": value.user!.uid,
      }).then((value) {
        //navigate to login page
        //display a snackbar with success message
        Get.snackbar("Success", "Account created successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAll(() => const LoginPage());
      }).catchError((onError) {
        Get.snackbar("Error", onError.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }
}
