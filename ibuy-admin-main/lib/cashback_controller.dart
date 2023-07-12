import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/cashback_modal.dart';

class CashbackController extends GetxController {
  final cashbacks = <CashbackModal>[].obs;
  final checkedAccounts = [].obs;
  final checked = <bool>[].obs;

  Future getCashbacks() async {
    cashbacks.clear();

    checkedAccounts.clear();
    checked.clear();
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("cashbacks").get();
      for (var element in snapshot.docs) {
        cashbacks.add(CashbackModal.fromMap(element));
        checked.add(false);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void pay() {
    for (var element in checkedAccounts) {
      FirebaseFirestore.instance
          .collection("cashbacks")
          .doc(element)
          .update({"paid": true});
    }

    getCashbacks().then((value) {
      Get.snackbar("Success", "Paid Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
  }
}
