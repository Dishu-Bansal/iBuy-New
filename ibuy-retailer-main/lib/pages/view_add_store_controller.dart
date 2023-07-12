import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/models/store_modal.dart';

class ViewAddStoreController extends GetxController {
  final checkedStores = [];
  final checked = <bool>[].obs;

  final stores = <StoreModal>[].obs;

  Future getStores() async {
    stores.clear();

    checkedStores.clear();
    checked.clear();
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("stores").get();
      for (var element in snapshot.docs) {
        stores.add(StoreModal.fromMap(element));
        checked.add(false);
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  void deleteStores() {
    for (var store in checkedStores) {
      FirebaseFirestore.instance
          .collection("stores")
          .doc(store)
          .delete()
          .then((value) => log("Store Deleted"));
      stores.remove(store);
    }
    //DISPLAY SUCCESS MESSAGE with snackbar
    Get.snackbar("Success", "Stores deleted successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);

    // //REFRESH THE LIST
    // stores.clear();
    // getStores();
  }

  void prepareEditStore() {
    var store = stores.firstWhere((element) => element.id == checkedStores[0]);

    storeName.text = store.storeName!;
    storeCode.text = store.storeCode!;
    province.text = store.province!;
    country.text = store.country!;
    postalCode.text = store.postalCode!;
    city.text = store.city!;
    add1.text = store.add1!;
    add2.text = store.add2!;
  }

  final storeName = TextEditingController();
  final storeCode = TextEditingController();
  final province = TextEditingController();
  final country = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final add1 = TextEditingController();
  final add2 = TextEditingController();

  void saveStore() {
    //update store
    if (checkedStores.length == 1) {
      FirebaseFirestore.instance
          .collection("stores")
          .doc(checkedStores[0])
          .update({
        'storeName': storeName.text,
        'storeCode': storeCode.text,
        'province': province.text,
        'country': country.text,
        'postalCode': postalCode.text,
        'city': city.text,
        'add1': add1.text,
        'add2': add2.text,
      }).then((value) {
        //DISPLAY SUCCESS MESSAGE with snackbar
        Get.snackbar("Success", "Store updated successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      }).catchError((onError) {
        //DISPLAY ERROR MESSAGE with snackbar
        Get.snackbar("Error", "Error updating store",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });

      Get.back();
    }
  }

  void addStore(
      storeName, storeCode, province, country, postalCode, city, add1, add2) {
    FirebaseFirestore.instance.collection("stores").doc().set({
      'storeName': storeName,
      'storeCode': storeCode,
      'province': province,
      'country': country,
      'postalCode': postalCode,
      'city': city,
      'add1': add1,
      'add2': add2,
    }).then((value) {
      //DISPLAY SUCCESS MESSAGE with snackbar
      Get.snackbar("Success", "Store added successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }).catchError((onError) {
      //DISPLAY ERROR MESSAGE with snackbar
      Get.snackbar("Error", "Error adding store",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });

    Get.back();
  }
}
