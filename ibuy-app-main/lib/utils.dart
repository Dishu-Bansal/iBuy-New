import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/grocery_budget_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/myuser.dart';

// import 'models/myuser.dart';

class Utils {
  static GoogleSignInAccount? googleUser;
  Future signInWithGoogle(BuildContext context) async {
    try {
      googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        AppRoutes.push(context, const GroceryBudgetScreen());
      }).catchError((onError) => null);

      await userUploadToDB(googleUser);
    } catch (e) {
      //display a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task failed: $e"),
        ),
      );
    }
  }
  //}

  Future<Position?> determinePosition() async {
    //print("determinePosition");
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await Geolocator.openAppSettings();
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openAppSettings();
      //return Future.error(
      //    'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    //print(Geolocator.getCurrentPosition());
    //show a snackar to display the location
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition();
    }

    //return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromLatLng(Position? position) async {
    if (position == null) {
      return "0";
    }

    String posCode = "0";
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks
              .where((element) =>
                  element.postalCode != null && element.postalCode!.isNotEmpty)
              .isEmpty
          ? placemarks[0]
          : placemarks
              .where((element) =>
                  element.postalCode != null && element.postalCode!.isNotEmpty)
              .first;
      print(placemarks
          .where((element) =>
              element.postalCode != null && element.postalCode!.isNotEmpty)
          .length);
      // print(place.administrativeArea);
      // print(place.country);
      // print(place.subLocality);
      posCode = (place.postalCode ?? "0").toString();
    });

    return posCode;
  }

  void setModelData(Map dat) {
    //print(dat["cards"]);
    Userr.userData.uid = dat["uid"];
    Userr.userData.imgUrl = dat["img_url"];
    Userr.userData.email = dat["email"];
    Userr.userData.name = dat["name"];
    Userr.userData.postalCode = dat["postalCode"].toString();
    Userr.userData.mailingAddress = dat["mailing_address"];
    Userr.userData.cards = [...dat["cards"]];
    Userr.userData.budget = dat["budget"];
    Userr.userData.createdAt = dat["createdAt"];
    Userr.userData.planId = dat["plan_id"];
  }

  void getDataFromDB(String uid) {
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((e) {
      Map<String, dynamic>? d = e.data();
      if (d != null) {
        setModelData(d);
      } else {
        //AppRoutes.replace(context, LoginClass());
      }
    });
  }

  Future<void> userUploadToDB(GoogleSignInAccount? googleUser) async {
    // await uploadPic(_img!);
    Map<String, dynamic> data = {
      "uid": googleUser!.id,
      "img_url": googleUser.photoUrl,
      "email": googleUser.email,
      "name": googleUser.displayName,
      "createdAt": DateTime.now().toString(),
      "mailing_address": "Not Setup yet",
      "plan_id": "",
      "budget": 0,
      "postalCode": "",
      "cards": [],
    };
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data)
        .then((va) async {});
  }

  //a function that will check if signed in user has correctly filled data in the cloud firestore
  Future<bool> checkIfUserHasFilledData() async {
    bool hasFilledData = false;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data();
        //print("budget: ${data!["budget"]}");
        if (data != null) {
          if (data["budget"] != 0 && data["plan_id"] != "") {
            hasFilledData = true;
          }
        }
      }
    });
    return hasFilledData;
  }

  //a function that will set the notification switch value to true initially when the app is installed using shared preferences
  Future<void> setNotificationSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", true);
  }

  //a function to get the notification switch value from shared preferences

  Future<bool> getNotificationSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool switchState = prefs.getBool("switchState") ?? false;
    return switchState;
  }

  //a function that will take notification text, time and date and save it in the cloud firestore
  Future<void> saveNotificationToDB(
      String notificationText, String time) async {
    Map<String, dynamic> data = {
      "text": notificationText,
      "time": time,
      "user_uid": FirebaseAuth.instance.currentUser!.uid,
    };
    await FirebaseFirestore.instance
        .collection("notifications")
        .doc()
        .set(data)
        .then((value) {});
  }

  //a function to set a bool value on device if it is the first time the app is being installed using shared preferences
  Future<void> setFirstTimeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstTime", true);
  }

  //a function to get the first time value from shared preferences
  Future<bool> getFirstTimeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool("firstTime") ?? false;
    return firstTime;
  }
}
