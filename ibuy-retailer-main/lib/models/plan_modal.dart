import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModal {
  String? startDate;
  String? enddate;
  int? maxCustomers;
  int? minSpend;
  int? usersEnrolled;
  double? maxSpend;
  double? minCashback;
  double? maxCashback;
  String? storeName;
  String? id;
  String? planName;
  Timestamp? creation;
  String? createdBy;
  double? cashback;
  bool? status;

  PlanModal({
    this.startDate,
    this.enddate,
    this.maxCustomers,
    this.minSpend,
    this.maxSpend,
    this.minCashback,
    this.maxCashback,
    this.storeName,
    this.creation,
    this.createdBy,
    this.status,
    this.cashback,
    this.planName,
    this.usersEnrolled,
    this.id,
  });

  PlanModal.fromMap(DocumentSnapshot map) {
    startDate = map['startDate'];
    enddate = map['endDate'];
    maxCustomers = map['maxCustomers'];
    minSpend = map['required_spend'];
    maxSpend = map['maxSpend'];
    minCashback = map['minCashback'];
    maxCashback = map['maxCashback'];
    storeName = map['company'];
    creation = map['creation'];
    createdBy = map['createdBy'];
    status = map['status'];
    cashback = map['cashback'];
    usersEnrolled = map['usersEnrolled'];
    id = map.id;
    planName = map['planName'];
  }
}
