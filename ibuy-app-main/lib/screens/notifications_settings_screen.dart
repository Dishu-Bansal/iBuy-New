import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _giveVerse = false;

  //a function to save the state of the switch locally using shared preferences
  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchState', value);
    print("switch state saved: " + value.toString());
  }

  @override
  void initState() {
    //read the state of the switch from shared preferences and set it to the switch

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _giveVerse = prefs.getBool('switchState') ?? false;
      });
    });
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Push Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Enable Notifications",
                style: TextStyle(fontSize: 15),
              ),
              CupertinoSwitch(
                value: _giveVerse,
                activeColor: const Color(0xffFEC107),
                onChanged: ((value) {
                  setState(() {
                    _giveVerse = value;
                  });
                  _saveSwitchState(value);
                }),
              ),
            ],
          ),
          Text("Help", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text("For any questions, Please email ibuymobileapp@gmail.com")
        ]),
      ),
    );
  }
}
