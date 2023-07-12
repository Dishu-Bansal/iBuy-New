import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/myuser.dart';
import '../utils.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/receipt_widget.dart';

class PlanStatusScreen extends StatefulWidget {
  const PlanStatusScreen({super.key});

  @override
  State<PlanStatusScreen> createState() => _PlanStatusScreenState();
}

class _PlanStatusScreenState extends State<PlanStatusScreen> {
  int target = 1;
  int spent = 0;
  String company = "";
  var budget = 1.0;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> plansList = [];

  var isLoading = false;
  void getReceipts() {
    spent = 0;
    try {
      print("User UID in plan status screen: " + Userr().uid.toString());
      print("Firebase UId: " + FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection('receipts')
          .where("user_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("status", isEqualTo: "approved")
          .get()
          .then((value) {
        for (var element in value.docs) {
          spent += int.parse(element.data()['totalSpend']);
        }

        print("spent: " + spent.toString());
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void getPlansList() {
    FirebaseFirestore.instance.collection('plans').get().then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      if (dat.isNotEmpty) {
        setState(() {
          plansList = dat;
        });

        getPlanWithId();
      }
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    budget = Userr.userData.budget;
    Utils().getDataFromDB(FirebaseAuth.instance.currentUser!.uid);
    print("User plan ID:" + Userr.userData.planId);
    getPlansList();
    getReceipts();
    setState(() {});

    super.initState();
  }

  void getPlanWithId() {
    // print("in plan with id");

    String idd = Userr.userData.planId;
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      //setState(() {
      idd = value.data()!['plan_id'];
      debugPrint("idd: $idd");
      //debugPrint("plansList.length ${plansList.length}");

      for (int i = 0; i < plansList.length; i++) {
        //print(plansList[i]['plan_id']);
        if (plansList[i].id == idd) {
          print("target" + plansList[i].data()['required_spend'].toString());
          setState(() {
            target = plansList[i].data()['required_spend'];
            company = plansList[i].data()['company'];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool planCompleted = spent / Userr.userData.budget >= 1 ? true : false;

    return Scaffold(
      drawer: const DrawerWidget(),
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          setState(() {
            Utils().getDataFromDB(FirebaseAuth.instance.currentUser!.uid);
            print("User plan ID:" + Userr.userData.planId);
            getPlansList();
            getReceipts();
          });
        }
      },
      appBar: AppBar(
        title: const Text(
          "Plan Status",
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(
          builder: (context) => (IconButton(
            icon: Image.asset("assets/drawer_icon.png"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          )),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: planCompleted
                              ? const Text(
                                  "Congratulations! You've completed the plan.")
                              : const Text("You're almost here!!!"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "Spent",
                                      style:
                                          TextStyle(color: Color(0xff999999)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "\$${spent.toString()}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: isLoading
                                          ? const CircularProgressIndicator()
                                          : LinearProgressIndicator(
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Color(0xffFEC107)),
                                              minHeight: 8,
                                              value: Userr.userData.budget > 0
                                                  ? spent /
                                                      Userr.userData.budget
                                                  : 0.0,
                                              color: const Color(0xffFEC107),
                                              backgroundColor:
                                                  const Color(0xffE8E8E8),
                                            ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 0),
                                        child: Text(
                                          "Target: ",
                                          style: TextStyle(
                                            color: Color(0xff999999),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${Userr.userData.budget.toString()}",
                                        style: const TextStyle(
                                          color: Color(0xff292D32),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      // const Text(
                                      //   "|",
                                      //   style: TextStyle(
                                      //       color: Color(0xff292D32),
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // const SizedBox(
                                      //   width: 5,
                                      // ),
                                      // const Padding(
                                      //   padding: EdgeInsets.only(bottom: 0),
                                      //   child: Text(
                                      //     "Budget: ",
                                      //     style: TextStyle(
                                      //       color: Color(0xff999999),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Text(
                                      //   "\$${Userr.userData.budget.toString()}",
                                      //   style: const TextStyle(
                                      //     color: Color(0xff292D32),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      CircleProgressBar(
                                        strokeWidth: 10,
                                        foregroundColor:
                                            const Color(0xff9D87FF),
                                        backgroundColor:
                                            const Color(0xffE8E8E8),
                                        value: 1,
                                        child: planCompleted
                                            ? const Icon(
                                                Icons.check,
                                                color: Color(0xff3DBB85),
                                                size: 60,
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  AnimatedCount(
                                                    fractionDigits: 0,
                                                    count: 100,
                                                    unit: '%',
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                  ),
                                                  Text("Time Left")
                                                ],
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "30",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "days",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      CircleProgressBar(
                                        strokeWidth: 10,
                                        foregroundColor: planCompleted
                                            ? const Color(0xff3DBB85)
                                            : const Color(0xff4EA3F2),
                                        backgroundColor: planCompleted
                                            ? const Color(0xff3DBB85)
                                            : const Color(0xffE8E8E8),
                                        value: spent >= Userr.userData.budget
                                            ? 0
                                            : 1 -
                                                (spent / Userr.userData.budget)
                                                    .toDouble(),
                                        child: planCompleted
                                            ? const Icon(
                                                Icons.check,
                                                color: Color(0xff3DBB85),
                                                size: 60,
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AnimatedCount(
                                                    fractionDigits: 0,
                                                    count: spent >=
                                                            Userr
                                                                .userData.budget
                                                        ? 0
                                                        : 100 -
                                                            (spent /
                                                                    Userr
                                                                        .userData
                                                                        .budget *
                                                                    100)
                                                                .toDouble(),
                                                    unit: '%',
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                  ),
                                                  const Text("Spending Left")
                                                ],
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            planCompleted
                                                ? const Text("")
                                                : Text(
                                                    "\$${spent.toString()}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          planCompleted
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "Continue shopping at your selected $company stores",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: planCompleted
                          ? const EdgeInsets.symmetric(vertical: 40)
                          : const EdgeInsets.symmetric(vertical: 0),
                      child: ReceiptWidget(
                        isPlanCompleted: planCompleted,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
