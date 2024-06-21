import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

Color kPrimaryColor = const Color(0xffFEC107);
Color sideBarColor = const Color(0xFF282828);
Color titleColor = const Color(0xff292D32);
Color titleBg = const Color(0xff275268);
void showToast(String msg, context) {
  FlutterToastr.show(
    msg,
    context,
    duration: 2,
    position: FlutterToastr.center,
    backgroundColor: Colors.red,
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
  );
}