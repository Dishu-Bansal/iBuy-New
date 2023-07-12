import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/pages/view_add_store_controller.dart';

class AddStore extends StatelessWidget {
  const AddStore({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final storeController = Get.put(ViewAddStoreController());
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFormField(
                    controller: storeController.country,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Country",
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
                        return "Country cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.storeCode,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Store Code",
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
                        return "Store code cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.storeName,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Store Name",
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
                        return "Store name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.add1,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Store Address 1",
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
                        return "Store address 1 cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: storeController.add2,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Store Address 2",
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
                        return "Store address 2 cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.city,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "City",
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
                        return "City cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.province,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Province",
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
                        return "Province cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: storeController.postalCode,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Postal Code",
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
                        return "Postal Code cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  //width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            storeController.addStore(
                                storeController.storeName.text,
                                storeController.storeCode.text,
                                storeController.province.text,
                                storeController.country.text,
                                storeController.postalCode.text,
                                storeController.city.text,
                                storeController.add1.text,
                                storeController.add2.text);
                          } else {
                            //display error message with snackbar
                            Get.snackbar(
                                "Input error", "Please fill all the fields");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff35BF84),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "ADD STORE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff999999),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "DISCARD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
