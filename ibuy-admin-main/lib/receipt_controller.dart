import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/models/receipt_modal.dart';

class ReceiptController extends GetxController {
  var currReceiptUrl = ''.obs;
  final receiptModals = <ReceiptModal>[].obs;
  var index = 0;
  var customerId = "".obs;
  List<ReceiptModal> pendingReceipts = List.empty(growable: true);

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

    pendingReceipts =
        receiptModals.where((p) => p.status == "Pending").toList();
    if (pendingReceipts.length >= 1) {
      customerId.value = pendingReceipts[index].userId!;
      currReceiptUrl.value = pendingReceipts[index].imageUrl!;
    }
  }

  void nextReceipt() {
    if (index >= pendingReceipts.length - 1) {
      index = 0;
    }
    currReceiptUrl.value = pendingReceipts[++index].imageUrl!;
    customerId.value = pendingReceipts[index].userId!;
  }

  void approveReceipt() {
    FirebaseFirestore.instance
        .collection('receipts')
        .doc(pendingReceipts[index].id)
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
      pendingReceipts.removeAt(index);
      currReceiptUrl.value = "";
      customerId.value = "";
      nextReceipt();
      clearTextFields();
    });

    //display a snackbar saying receipt approved
  }

  void rejectReceipt() {
    FirebaseFirestore.instance
        .collection('receipts')
        .doc(pendingReceipts[index].id)
        .update({'status': "rejected"}).then((value) {
      Get.snackbar(
        "Receipt Rejected",
        "Receipt has been Rejected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      pendingReceipts.removeAt(index);
      currReceiptUrl.value = "";
      customerId.value = "";
      nextReceipt();
      clearTextFields();
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
        .doc(pendingReceipts[index].id)
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
