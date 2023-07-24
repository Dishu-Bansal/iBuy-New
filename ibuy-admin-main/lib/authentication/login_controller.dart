import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  List<String> retailers = <String>[];

  Future<void> setRetailers() async {
    FirebaseFirestore.instance
        .collection("eligible-retailers")
        .doc("VsMhGAy0YjhUeWLDAEpn")
        .get()
        .then((value) {
      //retailers.clear();
      print(value.data()!["retailers"]);
      retailers = (value.data()!["retailers"] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      print(retailers);
    });
  }

  bool login() {
    //return true;
    if (emailController.text == "admin@ibuy.com" &&
        passwordController.text == "admin44") {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void updateRetailers(String newRetailer) {
    print(retailers);
    retailers.add(newRetailer);
    FirebaseFirestore.instance
        .collection("eligible-retailers")
        .doc("VsMhGAy0YjhUeWLDAEpn")
        .update({"retailers": retailers}).then((value) {
      //dispaly a snackbar with success message
      Get.snackbar("Success", "Retailers updated successfully");
    }).catchError((error) {
      //display a snackbar with error message
      Get.snackbar("Error", "Retailers could not be updated");
    });
  }
}
