import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';

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

  void addPlan() {
    //print("current user: ${FirebaseAuth.instance.currentUser!.uid}");
    FirebaseFirestore.instance
        .collection("plans")
        .doc(DateTime.now().toString())
        .set({
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
      "usersEnrolled": 0,
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

  void activatePlans() {
    for (var element in checkedPlans) {
      FirebaseFirestore.instance
          .collection("plans")
          .doc(element)
          .update({"status": true}).then((value) {
        getPlans();
      });
    }
    //display snackbar here to show that the plans have been deleted
    Get.snackbar("Plans Activated", "The selected plans have been activated",
        snackPosition: SnackPosition.BOTTOM);

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

  void savePlan() {
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
    }).then((value) {
      log("Plan Updated");
      Get.back();
      //getPlans();
    });
  }
}
