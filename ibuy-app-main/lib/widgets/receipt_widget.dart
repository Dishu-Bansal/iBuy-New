import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/grocery_budget_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

import '../camera_example.dart';
import '../models/myuser.dart';

class ReceiptWidget extends StatefulWidget {
  final bool isPlanCompleted;
  final bool anyPlan;
  const ReceiptWidget(
      {super.key, required this.isPlanCompleted, required this.anyPlan});

  @override
  State<ReceiptWidget> createState() => _ReceiptWidgetState();
}

class _ReceiptWidgetState extends State<ReceiptWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.isPlanCompleted || widget.anyPlan
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Don't like this plan?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: InkWell(
            child: InkWell(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("User")
                    .doc(Userr.userData.uid)
                    .update({
                  "plan_id": "",
                  "startDate": "",
                  "endDate": "",
                });
                await FirebaseFirestore.instance
                    .collection("User")
                    .doc(Userr.userData.uid)
                    .collection("plan_history")
                    .add({
                  "plan_id": Userr.userData.planId,
                  "budget": 0,
                  "status": "Cancelled",
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => GroceryBudgetScreen(true)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.black,
                    )),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: widget.isPlanCompleted || widget.anyPlan
                      ? const Text("Create a new Plan",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14))
                      : const Text(
                          "CANCEL AND CREATE NEW",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                ),
              ),
            ),
          ),
        ),
        widget.isPlanCompleted || widget.anyPlan
            ? const SizedBox()
            : Center(
                child: GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Or",
                    ),
                  ),
                ),
              ),
        widget.isPlanCompleted || widget.anyPlan
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                child: InkWell(
                  child: InkWell(
                    // onTap: () => Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const CameraScreen()),
                    //),
                    child: InkWell(
                      onTap: () =>
                          AppRoutes.push(context, const CameraExampleHome()),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff3DBB85),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "SCAN "
                            "RECEIPTS",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
