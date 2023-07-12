import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/authentication/create_account_screen.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/widgets/update_profile_widget.dart';
import 'package:intl/intl.dart';

import '../models/myuser.dart';
import '../screens/cashback_screen.dart';
import '../screens/notification_page.dart';
import '../screens/notifications_settings_screen.dart';
import '../screens/profile_main_screen.dart';
import '../screens/receipts_screen.dart';
import '../utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = "";
  String email = "";
  String postalCode = "";
  String dis = "this";
  final f = DateFormat("dd MMMM, yyyy");
  var isLoading = false;

  final user = FirebaseAuth.instance.currentUser;

  @override
  @override
  void initState() {
    super.initState();
    getDataFromDB(user!.uid);
  }

  void getDataFromDB(String uid) {
    setState(() {
      isLoading = true;
    });

    FirebaseFirestore.instance.collection("User").doc(uid).get().then((e) {
      Map<String, dynamic>? d = e.data();
      if (d != null) {
        //print("Data is not null");
        Utils().setModelData(d);
        name = Userr.userData.name.toString();
        email = Userr.userData.email.toString();
        postalCode = Userr.userData.postalCode;
        setState(() {
          isLoading = false;
        });
      } else {
        //AppRoutes.replace(context, LoginClass());
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  TextStyle greyStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: goldColor,
                ),
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 220,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color(0xffF3F3F3),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: Userr.userData.imgUrl!.isEmpty
                                    ? const AssetImage("assets/person.png")
                                    : NetworkImage(
                                            Userr.userData.imgUrl.toString())
                                        as ImageProvider,
                                // minRadius: 30,
                                maxRadius: 30,
                                minRadius: 30,
                                child: null,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      email,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  onPressed: (() {
                                    showModalBottomSheet<dynamic>(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) =>
                                                const UpdateProfileWidget())
                                        .then((value) {
                                      setState(() {
                                        name = value['name'];
                                        postalCode = value['postalCode'];
                                      });
                                    });
                                  }),
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(4),
                          //   child: Row(
                          //     children: [
                          //       const Text("UID - "),
                          //       Text(Userr.userData.uid.toString(),
                          //           style: greyStyle),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(4),
                          //   child: Row(
                          //     children: [
                          //       const Text("Creation - "),
                          //       Text(
                          //           f
                          //               .format(DateTime.parse(Userr
                          //                   .userData.createdAt
                          //                   .toString()))
                          //               .toString(),
                          //           style: greyStyle),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                const Text("Postal Code - "),
                                Text(postalCode.toString(), style: greyStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff666666),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset("assets/profile.png")),
                    title: const Text('Full Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ProfileMainScreen(),
                        ),
                      ).then((value) {
                        setState(() {
                          name = value['name'];
                          email = value['email'];
                        });
                      });
                    },
                  ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff666666),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset("assets/wallet.png")),
                    title: const Text('Order CashBack'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CashBackScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff666666),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset("assets/receipt-2.png")),
                    title: const Text('Reciepts'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const RecieptsScreen(),
                        ),
                      );
                    },
                  ),
                  // ListTile(
                  //   trailing: const Icon(Icons.arrow_forward_ios),
                  //   leading: Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xff666666),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Image.asset("assets/clock.png")),
                  //   title: const Text('Plan History'),
                  //   onTap: () {
                  //     // Update the state of the app.
                  //     // ...
                  //   },
                  // ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff666666),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset("assets/notification-bing.png")),
                    title: const Text('Notifications'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const NotificationsPage(),
                        ),
                      );
                    },
                  ),
                  // ListTile(
                  //   trailing: const Icon(Icons.arrow_forward_ios),
                  //   leading: Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xff666666),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Image.asset("assets/message-question.png")),
                  //   title: const Text('Help'),
                  //   onTap: () {
                  //     // Update the state of the app.
                  //     // ...
                  //   },
                  // ),
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff666666),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset("assets/setting-2.png")),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              const NotificationsSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 45, right: 20, left: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        FirebaseAuth.instance
                            .signOut()
                            .then((value) => Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const CreateAccountScreen(),
                                ),
                                ((route) => false)));
                        //Navigate to Create Account Screen
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
                  ),
                ],
              ),
      ),
    );
  }
}
