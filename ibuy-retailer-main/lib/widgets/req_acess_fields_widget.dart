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

class _RequestAccessFieldsWidgetState extends State<RequestAccessFieldsWidget> {
  bool loading = true;
  List<String> retailers = List.empty(growable: true);

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final retailerController = SingleValueDropDownController();

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
                DropDownTextField(
                  // initialValue: "name4",
                  controller: retailerController,
                  clearOption: true,

                  textFieldDecoration: InputDecoration(
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
                  clearIconProperty: IconProperty(color: kPrimaryColor),

                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownItemCount: 4,

                  dropDownList: retailers.map((e) {
                    return DropDownValueModel(name: e, value: e);
                  }).toList(),
                  /*const [
              DropDownValueModel(name: 'Retailer 1', value: "Retailer 1"),
              DropDownValueModel(
                name: 'Retailer 2',
                value: "Retailer 2",
              ),
              DropDownValueModel(name: 'Retailer 3', value: "Retailer 3"),
              DropDownValueModel(
                name: 'Retailer 4',
                value: "Retailer 4",
              ),
              // DropDownValueModel(name: 'name5', value: "value5"),
              // DropDownValueModel(name: 'name6', value: "value6"),
              // DropDownValueModel(name: 'name7', value: "value7"),
              // DropDownValueModel(name: 'name8', value: "value8"),
            ],*/
                  onChanged: (val) {},
                ),

                const SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    // print(emailController.text);
                    // print(retailer);
                    if (formKey.currentState!.validate()) {
                      Get.to(AccountActivationPage(
                        email: emailController.text,
                        retailer:
                            retailerController.dropDownValue!.value.toString(),
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
