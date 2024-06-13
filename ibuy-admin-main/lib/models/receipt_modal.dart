import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibuy_admin_app/models/retailer_modal.dart';

class ReceiptModal {
  String? imageUrl;
  int? time;
  String? userId;
  String? status;
  String? id;
  String? retailerName;
  String? trxDate;
  String? totalSpend;
  String? last4digits;
  String? planId;
  String? retailer;
  String? startDate;
  String? endDate;
  int? updateTime;

  ReceiptModal({
    this.imageUrl,
    this.time,
    this.userId,
    this.status,
    this.retailerName,
    this.last4digits,
    this.totalSpend,
    this.trxDate,
    this.planId,
    this.updateTime,
  });

  ReceiptModal.fromMap(DocumentSnapshot mape, List<RetailerModal> plans) {
    Map<String, dynamic> map = mape.data() as Map<String, dynamic>;
    imageUrl = map['receiptUrl'];
    time = map['time'];
    userId = map['user_uid'];
    status = map['status'];
    id = mape.id;
    retailerName = map['retailerName'];
    trxDate = map['trxDate'];
    totalSpend = map['totalSpend'];
    last4digits = map['last4Digits'];
    planId =
        plans.firstWhere((element) => element.id == map['plan_id']).planName;
    retailer =
        plans.firstWhere((element) => element.id == map['plan_id']).company;
    startDate =
        plans.firstWhere((element) => element.id == map['plan_id']).startDate;
    endDate =
        plans.firstWhere((element) => element.id == map['plan_id']).enddate;
    updateTime = map['update_time'];
  }
}
