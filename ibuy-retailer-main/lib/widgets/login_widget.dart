import 'package:flutter/material.dart';
import 'package:ibuy_app_retailer_web/authentication/login_page.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      },
      child: Container(
        decoration: BoxDecoration(
            //color: const Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.black,
            )),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
