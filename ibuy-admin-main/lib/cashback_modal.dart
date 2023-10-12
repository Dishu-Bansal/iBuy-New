import 'package:cloud_firestore/cloud_firestore.dart';

class CashbackModal {
  double? amount;
  String? status;
  String? uid;
  String? id;

  CashbackModal({
    this.amount,
    this.status,
    this.uid,
    this.id,
  });

  CashbackModal.fromMap(DocumentSnapshot map) {
    amount = map['amount'];
    status = map['status'];
    uid = map['uid'];
    id = map.id;
  }
}
