import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/authentication/confirm_password.dart';
import 'package:freelance_ibuy_app/authentication/create_account_screen.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';
import 'package:freelance_ibuy_app/screens/update_mailing_screen.dart';
import 'package:freelance_ibuy_app/screens/update_main_profile_screen.dart';

import 'add_card_details_screen.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({super.key});

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  String mailingAddress = Userr.userData.mailingAddress.toString();

  var cardDetails = Userr.userData.cards;
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
          onPressed: () => Navigator.pop(context, {
            "name": Userr.userData.name,
            "email": Userr.userData.email,
          }),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  //height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name & Account",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (contect) =>
                                              const UpdateMainProfileScreen()))
                                  .then((value) {
                                //print(value);
                                setState(() {
                                  Userr.userData.name = value["name"];
                                  Userr.userData.email = value["email"];
                                });
                              }),
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xff9D87FF)),
                              ),
                              child: const Text("UPDATE",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Userr.userData.name.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Email ID: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Userr.userData.email.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mailing Address",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (contect) =>
                                              const UpdateMailingAddress()))
                                  .then((value) {
                                setState(() {
                                  mailingAddress = value;
                                });
                              }),
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xff9D87FF)),
                              ),
                              child: const Text("UPDATE",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  250, // Adjust the width as per your requirements
                              child: Text(
                                mailingAddress,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Card Details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (contect) =>
                                              const AddCardDetails()))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    print("card" + value.toString());
                                    cardDetails.add(value);
                                  });
                                }
                              }),
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xff3DBB85)),
                              ),
                              child: const Text("ADD",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            // Text(
                            //   Userr.userData.mailingAddress.toString(),
                            //   style: const TextStyle(
                            //       fontWeight: FontWeight.normal),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Other Cards",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // TextButton(
                            //   onPressed: null,
                            //   style: ButtonStyle(
                            //     backgroundColor: MaterialStatePropertyAll(
                            //         Color(0xff3DBB85)),
                            //   ),
                            //   child: Text("ADD",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //       )),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: cardDetails == null
                              ? List.empty()
                              : List.generate(cardDetails.length,
                                  (index) => Text(cardDetails[index])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (contect) => const ConfirmPassword())),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "CHANGE PASSWORD",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();

                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const CreateAccountScreen()),
                          (route) => false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFF6359),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white),
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
}
