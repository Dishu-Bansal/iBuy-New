import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptModal {
  String? imageUrl;
  String? time;
  String? userId;
  String? status;
  String? id;
  String? retailerName;
  String? trxDate;
  String? totalSpend;
  String? last4digits;

  ReceiptModal({
    this.imageUrl,
    this.time,
    this.userId,
    this.status,
    this.retailerName,
    this.last4digits,
    this.totalSpend,
    this.trxDate,
  });

  ReceiptModal.fromMap(DocumentSnapshot map) {
    imageUrl = map['receiptUrl'];
    time = map['time'];
    userId = map['user_uid'];
    status = map['status'];
    id = map.id;
    retailerName = map['retailerName'];
    trxDate = map['trxDate'];
    totalSpend = map['totalSpend'];
    last4digits = map['last4Digits'];
  }
}
