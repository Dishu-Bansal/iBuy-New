import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../pages/account_controller.dart';
import 'login_widget.dart';

class AccountActivationFields extends StatelessWidget {
  final String email;
  final String retailer;
  const AccountActivationFields(
      {super.key, required this.email, required this.retailer});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final actController = Get.put(AccountActivationController());
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: actController.firstNameController,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              labelText: "First Name",
              //border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
              labelStyle: const TextStyle(color: Colors.black45),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "First Name cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: actController.lastNameController,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              labelText: "Last Name",
              //border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
              labelStyle: const TextStyle(color: Colors.black45),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Last Name cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: actController.passwordController,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              labelText: "Password",
              //border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
              labelStyle: const TextStyle(color: Colors.black45),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: actController.confirmPasswordController,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              labelText: "Re-enter Password",
              //border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
              labelStyle: const TextStyle(color: Colors.black45),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 50),
          InkWell(
            onTap: () {
              if (formKey.currentState!.validate()) {
                actController.createAndStoreAccount(email,
                    actController.confirmPasswordController.text, retailer);
              } else {
                //display error message with snackbar
                Get.snackbar("Error", "Please fill all the fields",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text(
                  "Active Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const LoginWidget(),
          const SizedBox(height: 40),
          const Text("iBuy Team | 2022")
        ],
      ),
    );
  }
}
