import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

final newPassword = TextEditingController();
final newPassword2 = TextEditingController();

class _ChangePassScreenState extends State<ChangePassScreen> {
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();



  bool isNewPasswordCorrect() {
    if (newPassword.text.toString().trim().length > 6) {
      return newPassword.text.trim() == newPassword2.text.trim();
    }
    return false;
  }

  void updatePass() {
    setState(() {
      isLoading = true;
    });

    if (isNewPasswordCorrect()) {
      final user = FirebaseAuth.instance.currentUser;
      user!.updatePassword(newPassword.text.trim()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Updated Successfully"),
          ),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Task failed: $error"),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New password does not match."),
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
          "Profile",
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: goldColor),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10),
                        //   child: TextFormField(
                        //     controller: currPassword,
                        //     obscureText: true,
                        //     cursorColor: Colors.grey,
                        //     decoration: InputDecoration(
                        //       labelText: "Current Password",
                        //       //border: OutlineInputBorder(),
                        //       fillColor: Colors.white,
                        //       filled: true,
                        //       labelStyle: const TextStyle(color: Colors.grey),

                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return "Password cannot be empty";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10),
                        //   child: TextFormField(
                        //     controller: newPassword,
                        //     obscureText: true,
                        //     cursorColor: Colors.grey,
                        //     decoration: InputDecoration(
                        //       helperText: "Minimum 6 Characters",
                        //       labelText: "New Password",
                        //       //border: OutlineInputBorder(),
                        //       fillColor: Colors.white,
                        //       filled: true,
                        //       labelStyle: const TextStyle(color: Colors.grey),
                        //
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return "New cannot be empty";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10),
                        //   child: TextFormField(
                        //     controller: newPassword2,
                        //     obscureText: true,
                        //     cursorColor: Colors.grey,
                        //     decoration: InputDecoration(
                        //       labelText: "Re enter Password",
                        //       //border: OutlineInputBorder(),
                        //       fillColor: Colors.white,
                        //       filled: true,
                        //       labelStyle: const TextStyle(color: Colors.grey),
                        //
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(35.0),
                        //         borderSide: const BorderSide(
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ),
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return "New Password cannot be empty";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        PasswordField(),
                        PasswordField2(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            updatePass();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all fields"),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff3DBB85),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
      controller: newPassword,
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
        labelText: "Enter your new Password",
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

class PasswordField2 extends StatefulWidget {
  const PasswordField2({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState2();
}

class _PasswordFieldState2 extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: newPassword2,
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
        labelText: "Re-enter your new Password",
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
