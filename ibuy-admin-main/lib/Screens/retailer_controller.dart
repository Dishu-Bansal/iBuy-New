import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/retailer_modal.dart';

class RetailerController extends GetxController {
  final checkedRetailers = [];
  var isLoading = false.obs;
  //create a observable list of bools that will handle the checkboxes
  final checked = <bool>[].obs;
  // create a observable bool

  final retailers = <RetailerModal>[].obs;

  Future getRetailers() async {
    retailers.clear();
    checkedRetailers.clear();
    checked.clear();
    try {
      var snapshot = await FirebaseFirestore.instance.collection("plans").get();
      for (var element in snapshot.docs) {
        retailers.add(RetailerModal.fromMap(element));
        checked.add(false);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
