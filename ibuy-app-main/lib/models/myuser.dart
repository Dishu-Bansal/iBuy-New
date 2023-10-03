class Userr {
  // singleton
  static final Userr _singleton = Userr._internal();
  factory Userr() => _singleton;

  Userr._internal();
  static Userr get userData => _singleton;
  String? uid = "";
  String? email = "";
  String? name = "";
  String? imgUrl = "";
  String? mailingAddress = "";
  String postalCode = "";
  double budget = 0;
  String? createdAt = "";
  String planId = "";
  List cards = [];
  String? end = "";
  String? start = "";
  String? retailer = "";
}
