import 'package:cloud_firestore/cloud_firestore.dart';

class CashbackModal {
  double? amount;
  String? date;
  bool? status;
  String? retailer;
  String? uid;
  String? id;

  CashbackModal({
    this.amount,
    this.date,
    this.status,
    this.retailer,
    this.uid,
  });

  CashbackModal.fromMap(DocumentSnapshot map) {
    amount = map['amount'];
    date = map['date'];
    status = map['paid'];
    retailer = map['retailer'];
    uid = map['user_uid'];
    id = map.id;
  }
}
