import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/plan_status_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';
import 'package:intl/intl.dart';
import '../widgets/plan_card.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final f = DateFormat("dd MMMM, yyyy");
  List<QueryDocumentSnapshot<Map<String, dynamic>>> plansList = [];
  var isLoading = false;

  //a function that will return retailer name from the retailer id

  void getPlansList() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('plans')
        .where("status", isEqualTo: true)
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      if (dat.isNotEmpty) {
        setState(() {
          plansList = dat;
        });
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: plansList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () {
                              _savePlan(plansList[index].id.toString());
                            },
                            child: PlanCard(
                              company: plansList[index]['company'].toString(),
                              cashback: plansList[index]['cashback'].toString(),
                              requiredSpend:
                                  plansList[index]['required_spend'].toString(),
                              endDate: (plansList[index]['endDate']).toString(),
                              retailerId:
                                  plansList[index]['createdBy'].toString(),
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

  void _savePlan(String id) {
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
          })
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Plan added successfully"),
                  ),
                ),
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
