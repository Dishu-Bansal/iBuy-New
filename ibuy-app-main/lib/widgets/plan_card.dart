import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanCard extends StatefulWidget {
  final String company;
  final String cashback;
  final String requiredSpend;
  final String endDate;
  final String retailerId;
  Widget button;
  PlanCard(
      {super.key,
      required this.company,
      required this.cashback,
      required this.requiredSpend,
      required this.endDate,
      required this.retailerId,
      required this.button});

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool loaded = false;
  int budget = 0;
  var retailerName = "";
  void getRetailerName(String retailerId) async {
    print("Retailer ID: " + retailerId.toString());

    await FirebaseFirestore.instance
        .collection("retailers")
        .doc(retailerId)
        .get()
        .then((value) {
      print("value" + value['retailer_name'].toString());
      setState(() {
        retailerName = value['retailer_name'];
      });
    });

    String id = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .get()
        .then((value) {
      budget = value['budget'];
    });
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    getRetailerName(widget.retailerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var retailerName = getRetailerName(widget.retailerId);
    // print("retailerName" + retailerName);
    return !loaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        retailerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Chip(
                        label: Text(
                          "${widget.cashback}% Cashback",
                          style: const TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Color(0xffFEC107),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Color(0xff999999)),
                          children: [
                            TextSpan(text: "Spend "),
                            TextSpan(
                              text: "\$" + budget.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(text: " before "),
                            TextSpan(
                                text: DateFormat("dd/MM/yyyy").format(
                                    DateTime.now().add(Duration(days: 28))),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: widget.button,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
