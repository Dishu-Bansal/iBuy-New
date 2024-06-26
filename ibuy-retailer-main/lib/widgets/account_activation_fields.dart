import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../pages/account_controller.dart';
import 'login_widget.dart';

final formKey = GlobalKey<FormState>();
final actController = Get.put(AccountActivationController());
class AccountActivationFields extends StatelessWidget {
  final String email;
  final String retailer;
  const AccountActivationFields(
      {super.key, required this.email, required this.retailer});

  @override
  Widget build(BuildContext context) {

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
          PasswordField(),
          const SizedBox(height: 30),
          Passwordfield2(),
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

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: actController.passwordController,
      cursorColor: Colors.black45,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,),
          onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          },),
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
    );
  }
}

class Passwordfield2 extends StatefulWidget {
  const Passwordfield2({super.key});

  @override
  State<Passwordfield2> createState() => _Passwordfield2State();
}

class _Passwordfield2State extends State<Passwordfield2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: actController.confirmPasswordController,
      cursorColor: Colors.black45,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,),
          onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          },),
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
    );
  }
}


