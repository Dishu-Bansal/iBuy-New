import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/authentication/create_account_screen.dart';
import 'package:freelance_ibuy_app/screens/plan_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/myuser.dart';

class SplashClass extends StatefulWidget {
  const SplashClass({Key? key}) : super(key: key);

  @override
  SplashClassState createState() => SplashClassState();
}

class SplashClassState extends State<SplashClass> {
  @override
  void initState() {
    delayTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: const Icon(
          Icons.abc,
          color: Colors.black,
        ),
      ),
      // This trailing comma makes auto-for,
    );
  }

  // Widget hooprLogo() {
  //   return Container(
  //     alignment: Alignment.center,
  //     color: Colors.white,
  //     child: const Image(
  //       image: AssetImage("images/hooprLoo.png"),
  //     ),
  //   );
  // }

  void delayTime() {
    Timer(const Duration(seconds: 1), appInstallCheck);
  }

  void appInstallCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? inst = pref.getBool("firstInstall");
    if (inst == false) {
      appUserCheck();
    } else {
      //AppRoutes.replace(context, const CreateAccountScreen());
    }
  }

  void appUserCheck() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      AppRoutes.replace(context, const CreateAccountScreen());
    } else {
      getDataFromDB(user.uid);
    }
  }

  void getDataFromDB(String uid) {
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((e) {
      Map<String, dynamic>? d = e.data();
      if (d != null) {
        setModelData(d);
      } else {
        AppRoutes.replace(context, const CreateAccountScreen());
      }
    });
  }

  void setModelData(Map dat) {
    Userr.userData.uid = dat["uid"];
    Userr.userData.imgUrl = dat["img_url"];

    Userr.userData.email = dat["email"];
    Userr.userData.name = dat["name"];
    Userr.userData.postalCode = dat["postalCode"];
    Userr.userData.budget = dat["budget"];
    Userr.userData.createdAt = dat["createdAt"];

    AppRoutes.replace(context, const PlanScreen());
  }
}
