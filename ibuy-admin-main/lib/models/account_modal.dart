import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibuy_admin_app/models/retailer_modal.dart';

class AccountModal {
  String? accId;
  String? email;
  String? retailerName;
  bool? status;
  int? creationDate;
  String? firstName;
  String? lastName;
  List<RetailerModal>? plans;
  double? sales;
  double? cashback;

  AccountModal({
    this.accId,
    this.email,
    this.retailerName,
    this.status,
    this.creationDate,
    this.firstName,
    this.lastName,
    this.plans,
    this.sales,
    this.cashback,
  });

  AccountModal.fromMap(DocumentSnapshot map, List<RetailerModal> plansList,
      double this.sales, double this.cashback) {
    accId = map['uid'];
    email = map['email'];
    retailerName = map['retailer_name'];
    status = map['status'];
    creationDate = map["creationDate"];
    firstName = map['firstName'];
    lastName = map['lastName'];
    plans = plansList;
  }
}
