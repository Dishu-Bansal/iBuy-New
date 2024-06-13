import 'package:cloud_firestore/cloud_firestore.dart';

class RetailerModal {
  String? startDate;
  String? enddate;
  String? company;
  int? maxCustomers;
  int? minSpend;
  int? usersEnrolled;
  double? maxSpend;
  double? minCashback;
  double? maxCashback;
  String? storeName;
  String? id;
  String? planName;
  int? creation;
  String? createdBy;
  double? cashback;
  String? status;
  int? count;
  int? served;

  RetailerModal(
      {this.startDate,
      this.enddate,
        this.company,
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
      this.count,
      this.served});

  RetailerModal.fromMap(DocumentSnapshot map) {
    startDate = map['startDate'];
    enddate = map['endDate'];
    company = map['company'];
    maxCustomers = map['maxCustomers'];
    minSpend = map['required_spend'];
    maxSpend = map['maxSpend'];
    minCashback = map['minCashback'];
    maxCashback = map['maxCashback'];
    storeName = map['company'];
    creation = map['creationDate'];
    createdBy = map['createdBy'];
    status = map['status'];
    cashback = map['cashback'];
    usersEnrolled = map['usersEnrolled'];
    id = map.id;
    planName = map['planName'];
    count = map['usersEnrolled'];
    served = map["customers_served"];
  }
}
