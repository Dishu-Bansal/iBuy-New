import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/authentication/login_controller.dart';

class AddRetailer extends StatefulWidget {
  const AddRetailer({Key? key}) : super(key: key);

  @override
  State<AddRetailer> createState() => _AddRetailerState();
}

class _AddRetailerState extends State<AddRetailer> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final loginController = Get.put(LoginController());
  bool loaded = false;
  List<String> retailers = [];

  getRetailers() async {
    await FirebaseFirestore.instance
        .collection("eligible-retailers")
        .doc("VsMhGAy0YjhUeWLDAEpn")
        .get()
        .then((value) {
      retailers.clear();
      retailers = (value.data()!["retailers"] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      print(retailers);
    });
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    getRetailers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: !loaded
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Text("Add Eligible Retailer",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: "Enter Retailers",
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
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: retailers.map((interest) {
                      return Chip(
                        label: Text(interest),
                        deleteIcon: const Icon(Icons.cancel),
                        onDeleted: () async {
                          retailers.remove(interest.toString());
                          await FirebaseFirestore.instance
                              .collection("eligible-retailers")
                              .doc("VsMhGAy0YjhUeWLDAEpn")
                              .update({"retailers": retailers}).then((value) {
                            //dispaly a snackbar with success message
                            Get.snackbar(
                                "Success", "Retailers updated successfully");
                          }).catchError((error) {
                            //display a snackbar with error message
                            Get.snackbar(
                                "Error", "Retailers could not be updated");
                          });
                          setState(() {});
                          ;
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    retailers.add(_textEditingController.text);
                    await FirebaseFirestore.instance
                        .collection("eligible-retailers")
                        .doc("VsMhGAy0YjhUeWLDAEpn")
                        .update({"retailers": retailers}).then((value) {
                      //dispaly a snackbar with success message
                      Get.snackbar("Success", "Retailers updated successfully");
                    }).catchError((error) {
                      //display a snackbar with error message
                      Get.snackbar("Error", "Retailers could not be updated");
                    });
                    setState(() {});
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
    );
  }
}
