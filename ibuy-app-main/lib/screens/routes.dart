import 'package:flutter/material.dart';

class AppRoutes {
  static void push(
    BuildContext context,
    Widget page,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushCall(BuildContext context, Widget page, Function function) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (context) => page),
    )
        .then((value) {
      function();
    });
  }

  static void replace(
    BuildContext context,
    Widget page,
  ) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void makeFirst(
    BuildContext context,
    Widget page,
  ) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void dismissAlert(context) {
    Navigator.of(context).pop();
  }
}
