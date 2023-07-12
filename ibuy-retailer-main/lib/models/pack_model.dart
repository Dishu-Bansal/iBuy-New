import 'package:cloud_firestore/cloud_firestore.dart';

class PackModel {
  String? name;
  Timestamp dateCreated = Timestamp.now();
  int? cashback;
  bool? isActive;
  int? users;

  PackModel(
      {required this.name,
      required this.dateCreated,
      required this.cashback,
      required this.isActive,
      required this.users});

  PackModel.fromMap(DocumentSnapshot map) {
    name = map['name'];
    dateCreated = map['date_created'];
    cashback = map['cashback'];
    isActive = map['isActive'];
    users = map['no_of_users'];
  }
}
