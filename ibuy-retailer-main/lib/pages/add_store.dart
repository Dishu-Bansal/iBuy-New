import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/pages/view_add_store_controller.dart';

GeoCode geoCode = GeoCode();
final formKey = GlobalKey<FormState>();
final storeController = Get.put(ViewAddStoreController());
class AddStore extends StatelessWidget {
  AddStore({super.key});

  @override
  Widget build(BuildContext context) {
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
                    readOnly: true,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Country",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),
                      enabled: false,
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
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Store name cannot be empty";
                    //   }
                    //   return null;
                    // },
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
                      labelText: "Street Number",
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
                        return "Street Number cannot be empty";
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
                      labelText: "Street Name",
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
                        return "Street Name cannot be empty";
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
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                    ),
                    items: [
                      "Ontario",
                      "Manitoba",
                      "British Columbia",
                      'Nova Scotia'
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
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
                    ),
                    onChanged: (value) {
                      storeController.province.text = value!;
                    },
                  ),
                  // child: TextFormField(
                  //   controller: storeController.province,
                  //   cursorColor: Colors.black45,
                  //   decoration: InputDecoration(
                  //     labelText: "Province",
                  //     //border: OutlineInputBorder(),
                  //     fillColor: Colors.white,
                  //     filled: true,
                  //     labelStyle: const TextStyle(color: Colors.black45),
                  //
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(35.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(35.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Province cannot be empty";
                  //     }
                  //     return null;
                  //   },
                  // ),
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
                     AddStoreButton(),
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

class AddStoreButton extends StatefulWidget {
  const AddStoreButton({super.key});

  @override
  State<AddStoreButton> createState() => _AddStoreButtonState();
}

class _AddStoreButtonState extends State<AddStoreButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () async {
        if(!loading)
          {
            setState(() {
              loading = true;
            });
            if (formKey.currentState!.validate()) {
              if (storeController.stores.any((element) =>
              element.storeCode! ==
                  storeController.storeCode.text)) {
                Get.snackbar("Input error",
                    "Same Store Code already exits.");
                setState(() {
                  loading = false;
                });
              } else {
                try {
                  Coordinates coord =
                  await geoCode.forwardGeocoding(
                      address: storeController.add1.text +
                          " " +
                          storeController.add2.text +
                          ", " +
                          storeController.city.text +
                          ", " +
                          storeController.province.text +
                          ", " +
                          storeController.country.text +
                          " " +
                          storeController.postalCode.text);
                  storeController.addStore(
                      storeController.storeName.text,
                      storeController.storeCode.text,
                      storeController.province.text,
                      storeController.country.text,
                      storeController.postalCode.text,
                      storeController.city.text,
                      storeController.add1.text,
                      storeController.add2.text);
                } catch (e) {
                  Get.snackbar(
                      "Input error",
                      "Error finding location. Please double check the address. " +
                          e.toString());
                  setState(() {
                    loading = false;
                  });
                }
              }
            } else {
              //display error message with snackbar
              Get.snackbar(
                  "Input error", "Please fill all the fields");
              setState(() {
                loading = false;
              });
            }
          }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff35BF84),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 10),
          child: loading ? Center(child: CircularProgressIndicator(),) : Text(
            "ADD STORE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

