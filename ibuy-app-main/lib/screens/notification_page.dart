import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/myuser.dart';
import '../widgets/notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> notifications = [];
  bool isLoading = false;
  void getNotifications() {
    print(Userr().uid);
    print(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('notifications')
        .where("user_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print(value.docs);
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      if (dat.isNotEmpty) {
        setState(() {
          notifications = dat;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffFEC107),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: notifications.isEmpty
                        ? const Text("No Notifications.")
                        : const Text(""),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: NotificationWidget(
                            text: notifications[index]['text'],
                            date: notifications[index]['time'],
                          ),
                        );
                      },
                      itemCount: notifications.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  TextStyle headingStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  TextStyle dateStyle() {
    return const TextStyle(color: Colors.grey);
  }
}
