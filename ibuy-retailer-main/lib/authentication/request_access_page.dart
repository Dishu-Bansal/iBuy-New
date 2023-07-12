import 'package:flutter/material.dart';
import 'package:ibuy_app_retailer_web/widgets/req_acess_fields_widget.dart';
import 'package:ibuy_app_retailer_web/widgets/side_bg_widget.dart';

class RequestAccessPage extends StatelessWidget {
  const RequestAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SideWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
              child: Column(
                children: [
                  Image.asset("logo.png"),
                  const SizedBox(height: 150),
                  const RequestAccessFieldsWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
