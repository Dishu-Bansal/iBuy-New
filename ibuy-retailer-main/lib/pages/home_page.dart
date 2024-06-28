import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibuy_app_retailer_web/constants.dart';
import 'package:ibuy_app_retailer_web/main-homepage-screens/packs_screen.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';
import 'package:ibuy_app_retailer_web/pages/cashback_plans.dart';
import 'package:ibuy_app_retailer_web/pages/sidebar_controller.dart';
import 'package:ibuy_app_retailer_web/pages/store_list.dart';
import 'package:ibuy_app_retailer_web/widgets/head.dart';

import '../authentication/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  String retailer_name = "";
  List<PlanModal> plans = [];

  getInfo() async {
    await FirebaseFirestore.instance
        .collection("retailers")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value != null) {
        QueryDocumentSnapshot<Map<String, dynamic>> doc = value.docs.first;
        retailer_name = doc["retailer_name"];
        retailer = doc["retailer_name"];
      }
    });
    await FirebaseFirestore.instance
        .collection("plans")
        .where("createdBy", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (DocumentSnapshot d in value.docs) {
        plans.add(PlanModal.fromMap(d));
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sidebarController = Get.put(SidebarController());

    List sideList = [
      'Home',
      'Store List',
      'Cashback Plans',
      //'Manage Plans',
    ];
    List sideIcons = [
      'home',
      'shop',
      'wallet',
      // 'layer',
    ];
    List subHeadings = [
      'Active Plans',
      'Stores',
      'Cashback Plans',
      //'Manage Cashback Plans',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Obx(() => Row(
                children: [
                  sideBar(sideList, sidebarController, sideIcons),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Head(
                          name: subHeadings[sidebarController.selIndex],
                          retailer: retailer_name,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 35, horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Active Plans: " +
                                    plans
                                        .where((element) =>
                                            element.status == "Active")
                                        .length
                                        .toString(),
                                style: GoogleFonts.openSans(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Completed Plans: " +
                                    plans
                                        .where((element) =>
                                            element.status == "At Capacity")
                                        .length
                                        .toString(),
                                style: GoogleFonts.openSans(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: pageBuilder(sidebarController)),
                      ],
                    ),
                  ),
                ],
              )),
    );
  }

  Widget sideBar(sideList, sidebarController, sideIcons) {
    return Container(
      width: 250,
      color: sideBarColor,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset("iBuy_Retailer_Logo.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(sideList.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child:
                    sideBarTile(index, sideList, sidebarController, sideIcons),
              );
            }),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: "Logout",
                  content: const Text("Are you sure, you want to logout?"),
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.black,
                  buttonColor: const Color(0xffE64141),
                  onConfirm: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Get.offAll(const LoginPage());
                    });
                  },
                );
              },
              child: Row(children: [
                SvgPicture.asset(
                  "sidebar_icons/logout.svg",
                  width: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Logout",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffE64141),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideBarTile(index, sideList, sidebarController, sideIcons) {
    return GestureDetector(
      onTap: () {
        sidebarController.updateIndex(index);
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: sidebarController.selectedIndex == index ? titleBg : null,
        ),
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: SvgPicture.asset(
                  'sidebar_icons/${sideIcons[index]}.svg',
                  color: sidebarController.selectedIndex == index
                      ? Colors.white
                      : titleColor,
                  width: 20,
                ),
              ),
              //whitespace
              const WidgetSpan(
                child: SizedBox(
                  width: 7,
                ),
              ),
              TextSpan(
                text: sideList[index],
                style: GoogleFonts.openSans(
                  color: sidebarController.selectedIndex == index
                      ? Colors.white
                      : titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageBuilder(sidebarController) {
    if (sidebarController.selectedIndex == 0) {
      return const PacksScreen();
    } else if (sidebarController.selectedIndex == 1) {
      return const StoreList();
    } else if (sidebarController.selectedIndex == 2) {
      return const CashBackPlans();
    }

    return const StoreList();
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final sidebarController = Get.put(SidebarController());
//
//     List sideList = [
//       'Home',
//       'Store List',
//       'Cashback Plans',
//       //'Manage Plans',
//     ];
//     List sideIcons = [
//       'home',
//       'shop',
//       'wallet',
//       // 'layer',
//     ];
//     List subHeadings = [
//       'Active Plans',
//       'Stores',
//       'Cashback Plans',
//       //'Manage Cashback Plans',
//     ];
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() => Row(
//             children: [
//               sideBar(sideList, sidebarController, sideIcons),
//               Flexible(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Head(
//                       name: subHeadings[sidebarController.selIndex],
//                     ),
//                     Expanded(child: pageBuilder(sidebarController)),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
//
//   Widget sideBar(sideList, sidebarController, sideIcons) {
//     return Container(
//       width: 250,
//       color: sideBarColor,
//       padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               child: Image.asset("sidebar_logo.png"),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(sideList.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5),
//                 child:
//                     sideBarTile(index, sideList, sidebarController, sideIcons),
//               );
//             }),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25),
//             child: GestureDetector(
//               onTap: () {
//                 Get.defaultDialog(
//                   title: "Logout",
//                   content: const Text("Are you sure, you want to logout?"),
//                   textConfirm: "Yes",
//                   textCancel: "No",
//                   confirmTextColor: Colors.white,
//                   cancelTextColor: Colors.black,
//                   buttonColor: const Color(0xffE64141),
//                   onConfirm: () {
//                     FirebaseAuth.instance.signOut().then((value) {
//                       Get.offAll(const LoginPage());
//                     });
//                   },
//                 );
//               },
//               child: Row(children: [
//                 SvgPicture.asset(
//                   "sidebar_icons/logout.svg",
//                   width: 20,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   "Logout",
//                   style: GoogleFonts.openSans(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xffE64141),
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget sideBarTile(index, sideList, sidebarController, sideIcons) {
//     return GestureDetector(
//       onTap: () {
//         sidebarController.updateIndex(index);
//       },
//       child: Container(
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: sidebarController.selectedIndex == index ? titleBg : null,
//         ),
//         padding: const EdgeInsets.all(10),
//         child: RichText(
//           text: TextSpan(
//             children: [
//               WidgetSpan(
//                 child: SvgPicture.asset(
//                   'sidebar_icons/${sideIcons[index]}.svg',
//                   color: sidebarController.selectedIndex == index
//                       ? Colors.white
//                       : titleColor,
//                   width: 20,
//                 ),
//               ),
//               //whitespace
//               const WidgetSpan(
//                 child: SizedBox(
//                   width: 7,
//                 ),
//               ),
//               TextSpan(
//                 text: sideList[index],
//                 style: GoogleFonts.openSans(
//                   color: sidebarController.selectedIndex == index
//                       ? Colors.white
//                       : titleColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget pageBuilder(sidebarController) {
//     if (sidebarController.selectedIndex == 0) {
//       return const PacksScreen();
//     } else if (sidebarController.selectedIndex == 1) {
//       return const StoreList();
//     } else if (sidebarController.selectedIndex == 2) {
//       return const CashBackPlans();
//     }
//
//     return const StoreList();
//   }
// }
