import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/screens/change_pass_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

final passController = TextEditingController();
class _ConfirmPasswordState extends State<ConfirmPassword> {
  var isLoading = false;
  //var gotError = false;
  final _formKey = GlobalKey<FormState>();

  final _user = FirebaseAuth.instance.currentUser;
  _confirmPass() {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _user!
          .reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: _user!.email.toString(),
          password: passController.text,
        ),
      )
          .then((value) {
        AppRoutes.push(context, const ChangePassScreen());
      }).catchError((error) {
        showToast("Error: ${error.toString()}", context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Input all the fields!",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirm Password",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PasswordField(),
              const SizedBox(
                height: 70,
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: goldColor,
                    )
                  : InkWell(
                      onTap: () => _confirmPass(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff3DBB85),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Proceed",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
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
      controller: passController,
      obscureText: _obscureText,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,),
          onPressed: (){
            setState(() {
              _obscureText = !_obscureText;
            });
          },),
        labelText: "Enter your current Password",
        //border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        labelStyle: const TextStyle(color: Colors.grey),

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

