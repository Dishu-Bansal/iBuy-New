import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/authentication/login_controller.dart';
import 'package:ibuy_admin_app/widgets/interest_widget.dart';

class AddRetailer extends StatelessWidget {
  const AddRetailer({super.key});

  @override
  Widget build(BuildContext context) {
    final loginControlelr = Get.put(LoginController());
    loginControlelr.setRetailers();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Add Eligible Retailer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          const InterestListWidget(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              loginControlelr.updateRetailers();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
