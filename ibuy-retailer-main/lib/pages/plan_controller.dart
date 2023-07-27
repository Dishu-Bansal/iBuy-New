import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';
import 'package:ibuy_app_retailer_web/models/store_modal.dart';
import 'package:ibuy_app_retailer_web/pages/view_add_store_controller.dart';

class PlanController extends GetxController {
  final checkedPlans = [];
  final checked = <bool>[].obs;

  final plans = <PlanModal>[].obs;

  final startDateCon = TextEditingController();
  final endDateCon = TextEditingController();
  final storeNameCon = TextEditingController();
  final minSpendCon = TextEditingController();
  final maxSpendCon = TextEditingController();
  final maxCustomersCon = TextEditingController();
  final minCashbackCon = TextEditingController();
  final maxCashbackCon = TextEditingController();
  final cashBack = TextEditingController();
  final planName = TextEditingController();
  final selectedStores = List.empty(growable: true);

  void prepareEdit() {
    var plan = plans.firstWhere((element) => element.id == checkedPlans[0]);
    startDateCon.text = plan.startDate!;
    endDateCon.text = plan.enddate!;
    storeNameCon.text = plan.storeName!;
    minSpendCon.text = plan.minSpend.toString();
    maxSpendCon.text = plan.maxSpend.toString();
    maxCustomersCon.text = plan.maxCustomers.toString();
    minCashbackCon.text = plan.minCashback.toString();
    maxCashbackCon.text = plan.maxCashback.toString();
    cashBack.text = plan.cashback.toString();
    planName.text = plan.planName.toString();
  }

  Future<void> prepareStoreEdit() async {
    var plan = plans.firstWhere((element) => element.id == checkedPlans[0]);
    final storeController = Get.put(ViewAddStoreController(), permanent: true);
    await storeController.getStores();
    int index = 0;
    for (StoreModal store in storeController.stores) {
      if (plan.selectedStore!.contains(store.id)) {
        storeController.checked[index] = true;
      }
      index++;
    }
    index = 0;
    for (bool checked in storeController.checked) {
      if (checked) {
        storeController.checkedStores.add(storeController.stores[index].id);
      }
      index++;
    }
  }

  Future getPlans() async {
    plans.clear();

    checkedPlans.clear();
    checked.clear();
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection("plans")
          .where("createdBy", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (var element in snapshot.docs) {
        plans.add(PlanModal.fromMap(element));
        checked.add(false);
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  void addPlan(List<String> stores) {
    //print("current user: ${FirebaseAuth.instance.currentUser!.uid}");
    FirebaseFirestore.instance.collection("plans").add({
      "startDate": startDateCon.text,
      "endDate": endDateCon.text,
      "company": storeNameCon.text,
      "required_spend": double.parse(minSpendCon.text),
      "maxSpend": double.parse(maxSpendCon.text),
      "maxCustomers": int.parse(maxCustomersCon.text),
      "minCashback": double.parse(minCashbackCon.text),
      "maxCashback": double.parse(minCashbackCon.text),
      "creation": DateTime.now(),
      "createdBy": FirebaseAuth.instance.currentUser!.uid,
      "cashback": double.parse(cashBack.text),
      "plan_id": DateTime.now().toString(),
      "planName": planName.text,
      "status": false,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
      "usersEnrolled": 0,
      "storesSelected": stores,
    }).then((value) {
      log("Plan Added");
      Get.back();
      getPlans();
    });
  }

  void deletePlans() {
    for (var element in checkedPlans) {
      FirebaseFirestore.instance.collection("plans").doc(element).delete();
    }
    //display snackbar here to show that the plans have been deleted
    Get.snackbar("Plans Deleted", "The selected plans have been deleted",
        snackPosition: SnackPosition.BOTTOM);

    // getPlans();
  }

  void activatePlans() async {
    for (var element in checkedPlans) {
      await FirebaseFirestore.instance
          .collection("retailers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.data()?["status"] == true) {
          await FirebaseFirestore.instance
              .collection("plans")
              .doc(element)
              .update({"status": true}).then((value) {
            getPlans();
          });
          Get.snackbar(
              "Plans Activated", "The selected plans have been activated",
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Error",
              "Your Account has been deactivated. Please contact the administrator before making any changes",
              snackPosition: SnackPosition.BOTTOM);
        }
      });
    }
    //display snackbar here to show that the plans have been deleted

    // getPlans();
  }

  void deactivatePlans() {
    for (var element in checkedPlans) {
      FirebaseFirestore.instance
          .collection("plans")
          .doc(element)
          .update({"status": false}).then((value) {
        getPlans();
      });
    }
    //display snackbar here to show that the plans have been deleted
    Get.snackbar(
        "Plans Deactivated", "The selected plans have been deactivated",
        snackPosition: SnackPosition.BOTTOM);
  }

  void savePlan(List<String> stores) {
    FirebaseFirestore.instance.collection("plans").doc(checkedPlans[0]).update({
      "startDate": startDateCon.text,
      "endDate": endDateCon.text,
      "company": storeNameCon.text,
      "required_spend": double.parse(minSpendCon.text),
      "maxSpend": double.parse(maxSpendCon.text),
      "maxCustomers": int.parse(maxCustomersCon.text),
      "minCashback": double.parse(minCashbackCon.text),
      "maxCashback": double.parse(minCashbackCon.text),
      "creation": DateTime.now(),
      "createdBy": FirebaseAuth.instance.currentUser!.uid,
      "cashback": double.parse(cashBack.text),
      "plan_id": DateTime.now().toString(),
      "planName": planName.text,
      "LastUpdate": DateTime.now().millisecondsSinceEpoch,
      "storesSelected": stores,
    }).then((value) {
      log("Plan Updated");
      Get.back();
      //getPlans();
    });
  }
}
