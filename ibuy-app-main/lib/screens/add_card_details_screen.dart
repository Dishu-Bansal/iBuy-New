import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';

class AddCardDetails extends StatefulWidget {
  List<String> cards;

  AddCardDetails(List<String> this.cards, {super.key});

  @override
  State<AddCardDetails> createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  final _formKey = GlobalKey<FormState>();
  final digitController1 = TextEditingController();
  final cardController1 = TextEditingController();
  final digitController2 = TextEditingController();
  final cardController2 = TextEditingController();
  final digitController3 = TextEditingController();
  final cardController3 = TextEditingController();

  var isLoading = false;

  @override
  @override
  void initState() {
    // TODO: implement initState
    if(widget.cards.elementAtOrNull(0) != null)
    {
      digitController1.value = TextEditingValue(text: widget.cards[0].substring(widget.cards[0].length-5));
      cardController1.value = TextEditingValue(text: widget.cards[0].split("/").first);
    }
    if(widget.cards.elementAtOrNull(1) != null)
    {
      digitController2.value = TextEditingValue(text: widget.cards[1].substring(widget.cards[1].length-5));
      cardController2.value = TextEditingValue(text: widget.cards[1].split("/").first);
    }
    if(widget.cards.elementAtOrNull(2) != null)
    {
      digitController3.value = TextEditingValue(text: widget.cards[2].substring(widget.cards[2].length-5));
      cardController3.value = TextEditingValue(text: widget.cards[2].split("/").first);
    }
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                        controller: digitController1,
                        obscureText: false,
                        cursorColor: Colors.grey,
                        onChanged: (value) {
                          digitController1.value = TextEditingValue(text: value);
                        },
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        value: cardController1.value.text,
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
                          cardController1.value = TextEditingValue(text: value ?? "");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: digitController2,
                        obscureText: false,
                        cursorColor: Colors.grey,
                        onChanged: (value) {
                          digitController2.value = TextEditingValue(text: value);
                        },
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        value: cardController2.value.text,
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
                          cardController2.value = TextEditingValue(text: value ?? "");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: digitController3,
                        obscureText: false,
                        cursorColor: Colors.grey,
                        onChanged: (value) {
                          digitController3.value = TextEditingValue(text: value);
                        },
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        value: cardController3.value.text,
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
                          cardController3.value = TextEditingValue(text: value ?? "");
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
                              // if(widget.isSpace)
                              //   {
                                  _save();
                              //   }
                              // else
                              //   {
                              //     showToast("Only 3 cards allowed", context);
                              //   }
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
      ),
    );
  }

  _save() {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String card1 =
          "${cardController1.text.toString().trim()}/ xxxx-xxxx- ${digitController1.text.toString().trim()}";
      String card2 =
          "${cardController2.text.toString().trim()}/ xxxx-xxxx- ${digitController2.text.toString().trim()}";
      String card3 =
          "${cardController3.text.toString().trim()}/ xxxx-xxxx- ${digitController3.text.toString().trim()}";
      //print(card);
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'cards': [card1, card2, card3]
      }).then((value) => Navigator.pop(context, [card1, card2, card3]));
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
