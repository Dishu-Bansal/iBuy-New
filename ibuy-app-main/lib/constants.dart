import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

const Color goldColor = Color(0xffFEC107);
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