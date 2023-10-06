import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/plan_status_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../locate.dart';
import '../models/myuser.dart';
import '../utils.dart';
import '../widgets/plan_card.dart';

class MyStore {
  String name = "";
  double lat = 0;
  double long = 0;
  QueryDocumentSnapshot<Map<String, dynamic>>? plan = null;

  MyStore(this.name, this.lat, this.long, this.plan);
}

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final f = DateFormat("dd MMMM, yyyy");
  List<QueryDocumentSnapshot<Map<String, dynamic>>> plansList = [];
  List<MyStore> storesList = [];
  Completer<GoogleMapController> _controller = Completer();
  var isLoading = false;
  Locate locate = Locate();
  Position? data = null;

  //a function that will return retailer name from the retailer id

  locateit() async {
    Position dat = await locate.determinePosition();
    return dat;
  }

  changePosition(MyStore store) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(store.lat, store.long), zoom: 16.0)));
  }

  void getPlansList() async {
    setState(() {
      isLoading = true;
    });
    data = await locateit();
    await FirebaseFirestore.instance
        .collection('plans')
        .where("status", isEqualTo: "Active")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      if (dat.isNotEmpty) {
        /*setState(() {*/
        plansList = dat;
        /*});*/
      }
    });
    await FirebaseFirestore.instance
        .collection('stores')
        .get()
        .then((value) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      if (dat.isNotEmpty) {
        storesList.clear();
        /*setState(() {*/
        for (QueryDocumentSnapshot store in dat) {
          if (store['plan'] != '') {
            if (plansList.any((element) => element.id == store['plan'])) {
              List<Location> coord = await locationFromAddress(store['add1'] +
                  ", " +
                  store['add2'] +
                  ", " +
                  store['city'] +
                  ", " +
                  store['province'] +
                  ", " +
                  store['country'] +
                  " " +
                  store['postalCode']);
              storesList.add(MyStore(
                  store['storeName'],
                  coord.first.latitude,
                  coord.first.longitude,
                  plansList
                      .firstWhere((element) => element.id == store['plan'])));
            }
          }
        }
        /*});*/
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getPlansList();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Plans",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xffFEC107),
              ),
            )
          : data == null
              ? Center(
                  child: Text(
                    "Please provide Location permission to continue. Either Restart the app or Use settings app",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  child:
                      //loop through plansList and return PlanCard
                      Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Select a plan that suits you best!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(data!.latitude, data!.longitude),
                              zoom: 10),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: List.generate(storesList.length, (index) {
                            MyStore store = storesList.elementAt(index);
                            return Marker(
                                markerId: MarkerId(store.name),
                                position: LatLng(store.lat, store.long));
                          }).toSet(),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: storesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () {
                                  changePosition(storesList.elementAt(index));
                                },
                                child: PlanCard(
                                  company: storesList
                                      .elementAt(index)
                                      .name
                                      .toString(),
                                  cashback: storesList
                                      .elementAt(index)
                                      .plan!['cashback']
                                      .toString(),
                                  requiredSpend: storesList
                                      .elementAt(index)
                                      .plan!['required_spend']
                                      .toString(),
                                  endDate: (storesList
                                          .elementAt(index)
                                          .plan!['endDate'])
                                      .toString(),
                                  retailerId: storesList
                                      .elementAt(index)
                                      .plan!['createdBy']
                                      .toString(),
                                  button: getButton(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget getButton(int index) {
    return MaterialButton(
      onPressed: () {
        _savePlan(storesList.elementAt(index).plan!.id.toString(),
            storesList.elementAt(index).plan!["endDate"]);
      },
      color: Colors.green,
      child: Text("Start!"),
      textColor: Colors.white,
    );
  }

  Future<void> _savePlan(String id, String end) async {
    setState(() {
      isLoading = true;
    });
    debugPrint("Plan Id: $id");
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var planId = value.data()!['plan_id'];
      debugPrint(value.data()!['plan_id']);
      if (planId != id) {
        debugPrint("in the condition");
        //Display a snack bar with error message
        FirebaseFirestore.instance
            .collection("plans")
            .doc(id)
            .get()
            .then((value) {
          int enrolledCount = value['usersEnrolled'];
          if (enrolledCount + 1 == value['maxCustomers']) {
            FirebaseFirestore.instance
                .collection("plans")
                .doc(id)
                .update({"status": "At Capacity"}).then((value) {
              debugPrint("updated");
            }).catchError((onError) {
              debugPrint(onError.toString());
            });
          }
          FirebaseFirestore.instance
              .collection("plans")
              .doc(id)
              .update({"usersEnrolled": enrolledCount + 1}).then((value) {
            debugPrint("updated");
          }).catchError((onError) {
            debugPrint(onError.toString());
          });
        });
      }
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            "plan_id": id,
            "endDate":
                DateTime.now().add(Duration(days: 28)).millisecondsSinceEpoch,
            "startDate": DateTime.now().millisecondsSinceEpoch,
          })
          .then((value) async => {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Plan added successfully"),
                  ),
                ),
                await Utils().getDataFromDB(Userr.userData.uid!),
                AppRoutes.push(context, const PlanStatusScreen()),
              })
          .catchError((onError) => {
                //Display a snack bar with error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error adding plan"),
                  ),
                )
              });
    });

    setState(() {
      isLoading = false;
    });
  }
}
