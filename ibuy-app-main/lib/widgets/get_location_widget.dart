import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/utils.dart';

import 'confirm_location.dart';

class GetLocationWidget extends StatefulWidget {
  static String postalCode = "";
  const GetLocationWidget({super.key});

  @override
  State<GetLocationWidget> createState() => _GetLocationWidgetState();
}

class _GetLocationWidgetState extends State<GetLocationWidget> {
  final TextEditingController _manualLocation = TextEditingController();
  var isLoading = false;
  Future<void> tap(BuildContext context) async {
    //create a timer when the functions starts and if time is more than 10 seconds then show the snackbar

    setState(() {
      isLoading = true;
    });
    await Utils().determinePosition().then(
      (value) async {
        print(value);
        await Utils().getAddressFromLatLng(value).then(
          (value) {
            //show the value in snackbar
            //convert the int value to String

            var valueString = value.toString();

            print(value);
            GetLocationWidget.postalCode = valueString;
            //GetLocationWidget.postalCode = value;
            //print(GetLocationWidget.postalCode);
            Navigator.pop(context);
            setState(() {
              isLoading = false;
            });
            showModalBottomSheet<dynamic>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) => ConfirmLocation(
                postalCode: GetLocationWidget.postalCode,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  "Please share your location to find \nCashback near you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _manualLocation,
                  obscureText: false,
                  cursorColor: Colors.grey,
                  //keyboardType: TextInputType.al,
                  decoration: InputDecoration(
                    labelText: "Share Location",
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
                      return "Location cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: InkWell(
                  onTap: () {
                    if (_manualLocation.text.isEmpty) {
                      //show a dialog box with  error message and return
                      showDialog<dynamic>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Location"),
                          content: const Text("Location cannot be empty"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );

                      return;
                    }
                    showModalBottomSheet<dynamic>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => ConfirmLocation(
                        postalCode: _manualLocation.text,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFEC107),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "GO",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Or, share your current location",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                child: InkWell(
                  onTap: () async {
                    await tap(context);
                  },
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
                        "CURRENT LOCATION",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
