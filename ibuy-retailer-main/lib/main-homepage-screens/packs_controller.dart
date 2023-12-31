import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';

class PacksController extends GetxController {
  final plans = <PlanModal>[].obs;

  // final packs = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  void getPacks() {
    FirebaseFirestore.instance
        .collection("plans")
        .where("createdBy", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        // print(element['name']);
        plans.add(PlanModal.fromMap(element));
      }
    });
  }
}
