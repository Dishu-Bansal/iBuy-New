import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModal {
  String? accId;
  String? email;
  String? retailerName;
  bool? status;

  AccountModal({
    this.accId,
    this.email,
    this.retailerName,
    this.status,
  });

  AccountModal.fromMap(DocumentSnapshot map) {
    accId = map['uid'];
    email = map['email'];
    retailerName = map['retailer'];
    status = map['status'];
  }
}
