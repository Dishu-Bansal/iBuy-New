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
  int? createdAt = 0;
  String planId = "";
  List<String> cards = [];
  int? end = 0;
  int? start = 0;
  String? retailer = "";
  double cashback = 0;
}
