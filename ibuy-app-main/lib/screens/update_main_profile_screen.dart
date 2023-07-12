import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';

import '../models/myuser.dart';
import '../utils.dart';

class UpdateMainProfileScreen extends StatefulWidget {
  const UpdateMainProfileScreen({super.key});

  @override
  State<UpdateMainProfileScreen> createState() =>
      _UpdateMainProfileScreenState();
}

class _UpdateMainProfileScreenState extends State<UpdateMainProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool validateInputs() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void setModelData(Map dat) {
    //setState(() {
    Userr.userData.uid = dat["uid"];
    Userr.userData.imgUrl = dat["img_url"];
    Userr.userData.email = dat["email"];
    Userr.userData.name = dat["name"];
    Userr.userData.postalCode = dat["postalCode"];
    Userr.userData.budget = dat["budget"];
    Userr.userData.createdAt = dat["createdAt"];
    //});
  }

  bool isLoading = false;
  void update() {
    setState(() {
      isLoading = true;
    });

    final data = {
      "name": "${_firstNameController.text} ${_lastNameController.text}",
      "email": _emailController.text,
    };

    FirebaseAuth.instance.currentUser!
        .updateEmail(_emailController.text)
        .then((value) {
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "name": "${_firstNameController.text} ${_lastNameController.text}",
        "email": _emailController.text,
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
    }).catchError((error) {
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
              child: CircularProgressIndicator(
                color: goldColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Update Name & Account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    //border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),

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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    //border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),

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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: _emailController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "Email ID",
                                    //border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),

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
                                      return "Email cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  update();
                                } else {
                                  //show snack bar with error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Please fill all the fields"),
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
