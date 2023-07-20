import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModal {
  String? storeName;
  String? storeCode;
  String? country;
  String? province;
  String? postalCode;
  String? city;
  String? add1;
  String? add2;
  String? id;
  String? createdBy;
  List<String>? plans;
  StoreModal(
      {this.storeName,
      this.storeCode,
      this.country,
      this.province,
      this.postalCode,
      this.city,
      this.add1,
      this.add2,
      this.createdBy,
      this.plans});

  StoreModal.fromMap(DocumentSnapshot map) {
    storeName = map['storeName'];
    storeCode = map['storeCode'];
    country = map['country'];
    province = map['province'];
    postalCode = map['postalCode'];
    city = map['city'];
    add1 = map['add1'];
    add2 = map['add2'];
    id = map.id;
  }
}
