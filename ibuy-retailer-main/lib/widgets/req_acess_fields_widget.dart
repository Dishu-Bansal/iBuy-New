import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/authentication/account_activation_page.dart';
import 'package:ibuy_app_retailer_web/constants.dart';
import 'package:ibuy_app_retailer_web/widgets/login_widget.dart';

class RequestAccessFieldsWidget extends StatefulWidget {
  const RequestAccessFieldsWidget({Key? key}) : super(key: key);

  @override
  State<RequestAccessFieldsWidget> createState() =>
      _RequestAccessFieldsWidgetState();
}

List<String> retailers = List.empty(growable: true);
String selectedRetailer = "";

class _RequestAccessFieldsWidgetState extends State<RequestAccessFieldsWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late SingleValueDropDownController retailerController;
  bool loading = true;

  fetchRetailers() async {
    FirebaseFirestore.instance
        .collection("eligible-retailers")
        .get()
        .then((value) {
      retailers.clear();
      for (var element in value.docs) {
        List<dynamic> x = element["retailers"];
        for (var a in x) {
          retailers.add(a.toString());
        }
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    retailerController = SingleValueDropDownController();
    fetchRetailers();
    super.initState();
  }

  @override
  void dispose() {
    retailerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black45,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black45,
                    ),
                    labelText: "Enter your Email ID",
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
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                //Display a drop down field with random data
                RetailerSelection(),
                const SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    // print(emailController.text);
                    // print(retailer);
                    if (formKey.currentState!.validate()) {
                      Get.to(AccountActivationPage(
                        email: emailController.text,
                        retailer: selectedRetailer,
                      ));
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
                        "Request Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const LoginWidget(),
                const SizedBox(height: 70),
                const Text("iBuy Team | 2022")
              ],
            ),
          );
  }
}

class RetailerSelection extends StatefulWidget {
  const RetailerSelection({Key? key}) : super(key: key);

  @override
  State<RetailerSelection> createState() => _RetailerSelectionState();
}

class _RetailerSelectionState extends State<RetailerSelection> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Choose your Retailer",
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
        if (value == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      items: retailers.map((e) {
        return DropdownMenuItem(child: Text(e), value: e);
      }).toList(),
      onChanged: (val) {
        setState(() {
          selectedRetailer = val.toString();
        });
      },
    );
  }
}
