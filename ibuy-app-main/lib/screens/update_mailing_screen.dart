import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';

class UpdateMailingAddress extends StatefulWidget {
  const UpdateMailingAddress({super.key});

  @override
  State<UpdateMailingAddress> createState() => _UpdateMailingAddressState();
}

class _UpdateMailingAddressState extends State<UpdateMailingAddress> {
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final houseController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();

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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Update Mailing Address",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: houseController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "House No / Appt. No",
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
                                      return "House No cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: cityController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "City",
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
                                      return "City cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: provinceController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "Province",
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
                                      return "Province cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: countryController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "Country",
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
                                      return "Country cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: postalCodeController,
                                  obscureText: false,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    labelText: "Postal Code",
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
                                      return "Postal Code cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          isLoading
                              ? const CircularProgressIndicator(
                                  color: goldColor,
                                )
                              : Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //validate the controllers
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          save();
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          //show the snackbar with error message
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Please fill all the fields"),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff3DBB85),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            )),
                                        width:
                                            MediaQuery.of(context).size.width,
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
            ),
    );
  }

  void save() {
    String mailing =
        "${houseController.text}, ${cityController.text}, ${provinceController.text}, ${countryController.text}, ${postalCodeController.text} ";

    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "mailing_address": mailing,
    }).then((value) {
      Navigator.pop(context, mailing);
    });
  }
}
