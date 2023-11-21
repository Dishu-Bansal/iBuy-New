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
          await FirebaseFirestore.instance.collection("cashback").get();
      for (var element in snapshot.docs) {
        if (cashbacks.any((ele) =>
            ele.uid == element["uid"] && ele.status == element["status"])) {
          int index = cashbacks.indexWhere(
              (e) => e.uid == element["uid"] && e.status == element["status"]);
          CashbackModal c = cashbacks.elementAt(index);
          c.amount = element["amount"];
          cashbacks[index] = c;
        } else {
          cashbacks.add(CashbackModal.fromMap(element));
          checked.add(false);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void pay() {
    for (var element in checkedAccounts) {
      FirebaseFirestore.instance
          .collection("cashback")
          .doc(element)
          .update({"status": "paid"});
    }

    getCashbacks().then((value) {
      Get.snackbar("Success", "Paid Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
  }
}
