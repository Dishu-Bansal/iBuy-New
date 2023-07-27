import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account_modal.dart';
import '../models/retailer_modal.dart';

class AccountController extends GetxController {
  final checkedAccounts = [];
  var isLoading = false.obs;
  //create a observable list of bools that will handle the checkboxes
  final checked = <bool>[].obs;
  // create a observable bool

  final accounts = <AccountModal>[].obs;

  Future getAccounts() async {
    print(isLoading.value);
    accounts.clear();
    checkedAccounts.clear();
    checked.clear();
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("retailers").get();
      for (var element in snapshot.docs) {
        List<RetailerModal> plans = [];
        var snapshot2 = await FirebaseFirestore.instance
            .collection("plans")
            .where("createdBy", isEqualTo: element.id)
            .get();
        for (var element2 in snapshot2.docs) {
          plans.add(RetailerModal.fromMap(element2));
        }
        accounts.add(AccountModal.fromMap(element, plans));
        checked.add(false);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void approveAccounts() {
    isLoading.value = true;
    for (var element in checkedAccounts) {
      FirebaseFirestore.instance
          .collection("retailers")
          .doc(element)
          .update({"status": true});
    }

    getAccounts().then((value) {
      Get.snackbar("Success", "Accounts Approved Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
    isLoading.value = false;

    //dispalay a snackbar
  }

  Future<void> rejectAccounts() async {
    isLoading.value = true;
    for (var element in checkedAccounts) {
      await FirebaseFirestore.instance
          .collection("retailers")
          .doc(element)
          .update({"status": false});

      await FirebaseFirestore.instance
          .collection("plans")
          .where("createdBy", isEqualTo: element)
          .get()
          .then((value) async {
        for (DocumentSnapshot plan in value.docs) {
          await FirebaseFirestore.instance
              .collection("plans")
              .doc(plan.id)
              .update({"status": false});
        }
      });
    }

    getAccounts().then((value) {
      //dispalay a snackbar
      Get.snackbar("Success", "Accounts Rejected Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    });
    isLoading.value = false;
  }
}
