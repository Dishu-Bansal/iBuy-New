import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/models/receipt_modal.dart';

class ReceiptController extends GetxController {
  var currReceiptUrl = ''.obs;
  final receiptModals = <ReceiptModal>[].obs;
  var index = 0;
  var customerId = "".obs;

  //Text editing controllers

  TextEditingController retailerName = TextEditingController();
  TextEditingController trxDate = TextEditingController();
  TextEditingController totalSpend = TextEditingController();
  TextEditingController last4Digits = TextEditingController();

  //call the getReceipt function when the controller is initialized

  Future getReceiptModals() async {
    receiptModals.clear();
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("receipts").get();
      for (var element in snapshot.docs) {
        receiptModals.add(ReceiptModal.fromMap(element));
      }
    } catch (e) {
      print("Error: $e");
    }

    customerId.value = receiptModals[index].userId!;
    currReceiptUrl.value = receiptModals[index].imageUrl!;
  }

  void nextReceipt() {
    if (index >= receiptModals.length - 1) {
      index = 0;
    }
    currReceiptUrl.value = receiptModals[++index].imageUrl!;
    customerId.value = receiptModals[index].userId!;
  }

  void approveReceipt() {
    FirebaseFirestore.instance
        .collection('receipts')
        .doc(receiptModals[index].id)
        .update({
      'status': "approved",
      'retailerName': retailerName.text,
      'trxDate': trxDate.text,
      'totalSpend': totalSpend.text,
      'last4Digits': last4Digits.text,
    }).then((value) {
      Get.snackbar(
        "Receipt Approved",
        "Receipt has been approved",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nextReceipt();
      clearTextFields();
    });

    //display a snackbar saying receipt approved
  }

  void rejectReceipt() {
    FirebaseFirestore.instance
        .collection('receipts')
        .doc(receiptModals[index].id)
        .update({'status': "rejected"}).then((value) {
      Get.snackbar(
        "Receipt Rejected",
        "Receipt has been Rejected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nextReceipt();
    });
  }

  void clearTextFields() {
    retailerName.clear();
    trxDate.clear();
    totalSpend.clear();
    last4Digits.clear();
  }

  void reUpload() {
    FirebaseFirestore.instance
        .collection('receipts')
        .doc(receiptModals[index].id)
        .update({'status': 'reupload'}).then((value) {
      Get.snackbar(
        "Receipt Status",
        "Changes Saved",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nextReceipt();
    });
  }
}
