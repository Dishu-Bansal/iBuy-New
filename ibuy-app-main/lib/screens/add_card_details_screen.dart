import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';

class AddCardDetails extends StatefulWidget {
  bool isSpace;

  AddCardDetails(bool this.isSpace, {super.key});

  @override
  State<AddCardDetails> createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  final _formKey = GlobalKey<FormState>();
  final digitController = TextEditingController();
  final cardController = TextEditingController();

  var isLoading = false;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add Card Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: digitController,
                      obscureText: false,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelText: "Last 4 digits",
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digits cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: TextFormField(
                  //     controller: cardController,
                  //     obscureText: false,
                  //     cursorColor: Colors.grey,
                  //     decoration: InputDecoration(
                  //       labelText: "Card Type",
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
                  //         return "Cards cannot be empty";
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Card Type",
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
                        return value == null ? "Please select a type" : null;
                      },
                      items:
                      [DropdownMenuItem<String>(value: "VISA", child: Text("VISA"),),DropdownMenuItem<String>(value: "MasterCard", child: Text("MasterCard"),),DropdownMenuItem<String>(value: "AMEX", child: Text("AMEX"),),],
                      onChanged: (String? value) {
                        cardController.value = TextEditingValue(text: value ?? "");
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  isLoading
                      ? const CircularProgressIndicator(
                          color: goldColor,
                        )
                      : InkWell(
                          onTap: () {
                            if(widget.isSpace)
                              {
                                _save();
                              }
                            else
                              {
                                showToast("Only 3 cards allowed", context);
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
      ),
    );
  }

  _save() {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String card =
          "${cardController.text.toString().trim()}/ xxxx-xxxx- ${digitController.text.toString().trim()}";
      //print(card);
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'cards': FieldValue.arrayUnion([card])
      }).then((value) => Navigator.pop(context, card));
    } else {
      //display a snackbar with error message "Please fill all the fields"
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
