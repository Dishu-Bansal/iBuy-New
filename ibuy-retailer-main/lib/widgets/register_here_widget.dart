import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterHereWidget extends StatelessWidget {
  const RegisterHereWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "New User?",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          child: const Text(
            "Register Here",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
