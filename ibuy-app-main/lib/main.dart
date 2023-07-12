import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/intro.dart';
import 'package:freelance_ibuy_app/screens/grocery_budget_screen.dart';
import 'package:freelance_ibuy_app/screens/plan_status_screen.dart';
import 'package:freelance_ibuy_app/utils.dart';

import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final _cameras = await availableCameras();
  await Firebase.initializeApp();
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("token: " + token.toString());
  await FirebaseMessaging.instance.subscribeToTopic("all");
  //Utils().setNotificationSwitchValue();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasFilledData = false;
  Future<bool> switchState = Future.value(false);

  late BuildContext scaffoldContext;
  @override
  void initState() {
    super.initState();
    initializeApp();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      showNotification(message.data['id']);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> checkUserFilledData() async {
    bool filledData = await Utils().checkIfUserHasFilledData();
    //print("budget" + filledData.toString());

    hasFilledData = filledData;
    //});
  }

  Future<void> initializeApp() async {
    bool firstTime = await Utils().getFirstTimeValue();
    if (firstTime) {
      await Utils().setFirstTimeValue();
      await Utils().setNotificationSwitchValue();
    }

    // Fetch the notification switch value
    bool switchValue = await Utils().getNotificationSwitchValue();
    print("switchValue: " + switchValue.toString());

    // Generate the notification stream or perform other initialization tasks based on the switch value
    if (switchValue) {
      FirebaseFirestore.instance
          .collection('receipts')
          .snapshots()
          .listen((event) {
        for (var element in event.docChanges) {
          print(element.doc.data()!['user_uid']);
          if (element.doc.data()!['user_uid'] ==
              FirebaseAuth.instance.currentUser!.uid) {
            print("uid");
            if (element.type == DocumentChangeType.modified) {
              print("Status: " + element.doc.data()!['status'].toString());
              if (element.doc.data()!['status'] == "approved") {
                sendNotificationTo(
                    "Receipt Approved", "Your receipt has been approved", "1");
              } else if (element.doc.data()!['status'] == "reupload") {
                sendNotificationTo("Receipt Rejected",
                    "Please upload the receipt again.", "3");
              } else if (element.doc.data()!['status'] == "rejected") {
                sendNotificationTo(
                    "Receipt Pending", "Your receipt has been rejected", "2");
              }
            }
          }
        }
      });

      //a stream to the cashback collection, send a notification when the cashback is paid
      FirebaseFirestore.instance
          .collection('cashbacks')
          .snapshots()
          .listen((event) {
        for (var element in event.docChanges) {
          print(element.doc.data()!['user_uid']);
          if (element.doc.data()!['user_uid'] ==
              FirebaseAuth.instance.currentUser!.uid) {
            if (element.type == DocumentChangeType.modified) {
              if (element.doc.data()!['paid']) {
                sendNotificationTo(
                    "Cashback Paid", "Your cashback has been paid", "4");
              }
            }
          }
        }
      });
    }
  }

  void showNotification(String id) {
    String currTime = DateTime.now().toString();
    if (id == "1") {
      //if receipt is approved
      showSimpleNotification(
        const Text("Your receipt has been approved"),
        background: Colors.green,
        autoDismiss: false,
        trailing: Builder(builder: (context) {
          return ElevatedButton(
              // textColor: Colors.yellow,
              onPressed: () {
                OverlaySupportEntry.of(context)!.dismiss();
              },
              child: const Text('Dismiss'));
        }),
      );
      Utils().saveNotificationToDB("Your receipt has been approved", currTime);
    } else if (id == "2") {
      //if receipt is rejected
      showSimpleNotification(
        const Text("Your receipt has been rejected."),
        background: Colors.red,
        autoDismiss: false,
        trailing: Builder(builder: (context) {
          return ElevatedButton(
              // textColor: Colors.yellow,
              onPressed: () {
                OverlaySupportEntry.of(context)!.dismiss();
              },
              child: const Text('Dismiss'));
        }),
      );
      Utils()
          .saveNotificationToDB("Your receipt has been rejeceted.", currTime);
    } else if (id == "3") {
      //if receipt is reupload
      showSimpleNotification(
        const Text("Please reupload the receipt"),
        background: Colors.orange,
        autoDismiss: false,
        trailing: Builder(builder: (context) {
          return ElevatedButton(
              // textColor: Colors.yellow,
              onPressed: () {
                OverlaySupportEntry.of(context)!.dismiss();
              },
              child: const Text('Dismiss'));
        }),
      );
      Utils().saveNotificationToDB("Please reupload the receipt.", currTime);
    } else if (id == "4") {
      showSimpleNotification(
        const Text("Congrats, you're cashback has been approved."),
        background: Colors.green,
      );

      Utils().saveNotificationToDB(
          "Congrats, you're cashback has been approved. ", currTime);
    }
  }

  sendNotification(String title, String body, String token, String id,
      {String? payload}) async {
    final data = {
      "notification": {
        "title": title,
        "body": body,
      },
      "priority": "HIGH",
      "data": {
        "payload": payload,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": id,
        "status": "done",
        "sounds": true
      },
      "to": token
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAH6zrtXA:APA91bGC7SYdhPMyoTAeUqtBSgK8bAcA0FmLiP4Z-b24Bn1NMCm-dhR9SUMjucWEQb2o0hpeU6aEhczth_PfkMSabl6rfeU1XkkV-Jp6A1Riiq-rRcClU4_p0ozeud1HjLnh7JtG75G4'
    };

    const postUrl = 'https://fcm.googleapis.com/fcm/send';

    try {
      final response = await http.post(
        Uri.parse(postUrl),
        body: jsonEncode(data),
        headers: headers,
      );

      //print(response.body);
    } catch (e) {
      print('exception $e');
    }
  }

  // a function to get the token of the device
  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  //send the notification to the device
  Future<void> sendNotificationTo(String title, String body, String id) async {
    String? token = await getToken();
    print(token);
    await sendNotification(title, body, token!, id);
  }

  @override
  Widget build(BuildContext context) {
    //create a stream to listen to the changes in the firestore

    //sendNotificationToUser();

    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      checkUserFilledData().then((value) {
        if (hasFilledData == false) {
          return const OverlaySupport(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home:
                  GroceryBudgetScreen(), // Replace `AnotherScreen` with the screen you want to navigate to.
            ),
          );
        }
      });
    }

    //print(user);
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user == null ? const IntroScreen() : const PlanStatusScreen(),
      ),
    );
  }
}
