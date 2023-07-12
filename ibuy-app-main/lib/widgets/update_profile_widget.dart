import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';

import '../screens/plan_screen.dart';
import '../utils.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  //Validate the text controllers
  bool validateInputs() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool isLoading = false;
  void update() {
    final data = {
      "name": _nameController.text.toString().trim(),
      "postalCode": _postalCodeController.text.toString().trim()
    };
    setState(() {
      isLoading = true;
    });

    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": _nameController.text,
      "postalCode": int.parse(_postalCodeController.text),
    }).then((_) {
      Utils().getDataFromDB(FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        isLoading = false;
      });
      Navigator.pop(context, data);
    }).onError((error, stackTrace) {
      //display error message
      setState(() {
        isLoading = false;
      });
      //show snack bar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task failed: $error"),
        ),
      );
    });

    //Upadte the model
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.cancel)),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Text(
                "Update Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: _nameController,
              obscureText: false,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelText: "Name",
                //border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                labelStyle: const TextStyle(color: Colors.black45),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _postalCodeController,
              obscureText: false,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelText: "Postal Code",
                //border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                labelStyle: const TextStyle(color: Colors.black45),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Postal code cannot be empty";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PlanScreen(),
                    ),
                  );
                },
                child: InkWell(
                  onTap: () {
                    if (validateInputs()) {
                      update();
                    } else {
                      //show snack bar with error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields"),
                        ),
                      );
                    }
                    // Navigator.pop(context);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: goldColor,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff3DBB85),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
