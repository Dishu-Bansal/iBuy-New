import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/plan_screen.dart';
import 'get_location_widget.dart';

class ConfirmLocation extends StatefulWidget {
  final String postalCode;
  const ConfirmLocation({super.key, required this.postalCode});

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  //update fields in the firestore
  Future<void> updateFields() async {
    //print("heyy");
    Map<String, dynamic> data = {
      "postalCode": widget.postalCode,
      //"img_url": InputUserDetails.imgUrl,
    };
    //print(data['postalCode']);
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data)
        .onError((error, stackTrace) {
      //display a snackbar with error message\
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task failed: $error"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.cancel)),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(25),
          child: Text(
            "Want to continue with ths postal code?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.postalCode.toString(),
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: InkWell(
            onTap: () {
              updateFields();
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PlanScreen(),
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
                  "Continue",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            // onTap: () => Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const SignUp()),
            // ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Or",
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: InkWell(
            onTap: () {
              updateFields();
              Navigator.pop(context);
              showModalBottomSheet<dynamic>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) => const GetLocationWidget(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text(
                  "CHANGE LOCATION",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
