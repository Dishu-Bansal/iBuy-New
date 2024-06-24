import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibuy_admin_app/Screens/add_retailer.dart';
import 'package:ibuy_admin_app/Screens/cashback_screen.dart';
import 'package:ibuy_admin_app/Screens/process_receipt_screen.dart';
import 'package:ibuy_admin_app/Screens/receipts_screen.dart';
import 'package:ibuy_admin_app/sidebar_controller.dart';

import '../authentication/login_page.dart';
import 'Screens/account_screen.dart';
import 'Screens/retailers_plans_screen.dart';
import 'constants.dart';
import 'widgets/head.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sidebarController = Get.put(SidebarController());

    List sideList = [
      'Home',
      'Retailer Plan',
      'Receipts',
      'Process Receipts',
      'Process Cashback',
      'Add Retailers',
    ];
    List sideIcons = [
      'home',
      'shop-add',
      'receipt',
      'receipt-text',
      'wallet',
      'wallet',
    ];
    List subHeadings = [
      'Account Approval',
      'Retailer Plans',
      'Receipts',
      'Process Receipts',
      'Process Cashback',
      'Add Retailers',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Row(
            children: [
              sideBar(sideList, sidebarController, sideIcons),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Head(
                      name: subHeadings[sidebarController.selectedIndex.value],
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
              child: Image.asset("sidebar_logo.png"),
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
                  content: const Text("Are you sure you want to logout?"),
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.black,
                  buttonColor: const Color(0xffE64141),
                  onConfirm: () {
                    Get.offAll(
                      () => const LoginPage(),
                    );
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
          //color: sidebarController.selectedIndex == index ? titleBg : null,
          border: Border.all(
            color: sidebarController.selectedIndex == index
                ? kPrimaryColor
                : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: SvgPicture.asset(
                  'sidebar_icons/${sideIcons[index]}.svg',
                  color: sidebarController.selectedIndex == index
                      ? kPrimaryColor
                      : Colors.white,
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
                      ? kPrimaryColor
                      : Colors.white,
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
      return const AccountsScreen();
    } else if (sidebarController.selectedIndex == 1) {
      return const RetailersPlansScreen();
    } else if (sidebarController.selectedIndex == 2) {
      return const ReceiptsScreen();
    } else if (sidebarController.selectedIndex == 3) {
      return const ProcessReceiptScreen();
    } else if (sidebarController.selectedIndex == 4) {
      return const CashbackScreen();
    } else {
      return AddRetailer();
    }
  }
}
