import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';

class Cashback {
  String? uid = "";
  String? status = "";
  double? amount = 0;
  String? id = "";

  Cashback(this.id, this.uid, this.status, this.amount);
}

class CashBackScreen extends StatefulWidget {
  const CashBackScreen({super.key});

  @override
  State<CashBackScreen> createState() => _CashBackScreenState();
}

class _CashBackScreenState extends State<CashBackScreen> {
  var isEligible = false;
  int requiredSpend = 0;
  double redemedCashback = 0;
  double redemableCashback = 0;
  bool alreadyApplied = false;
  bool casbackPaid = false;
  var retailer = "";
  int spent = 0;
  double cashback = 0;
  double inProcessCashback = 0;
  bool loading = true;
  bool ongoingPlan = false;
  double earnedCashback = 0;
  double paidcashback = 0;
  double processingcashback = 0;
  double pendingcashback = 0;
  List<Cashback> cashbacks = List.empty(growable: true);

  void requestCashback() async {
    for (Cashback i in cashbacks) {
      if (i.status == "eligible") {
        await FirebaseFirestore.instance
            .collection('cashback')
            .doc(i.id)
            .update({
          "status": "processing",
        }).then((value) {
          setState(() {});
          //display success message with snackbar
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cashback requested successfully"),
            ),
          );
        });
      }
    }
  }

  getCashback() async {
    await FirebaseFirestore.instance
        .collection("cashback")
        .where("uid", isEqualTo: Userr.userData.uid)
        .get()
        .then((value) {
      cashbacks.clear();
      for (DocumentSnapshot current in value.docs) {
        cashbacks.add(Cashback(
            current.id, current["uid"], current["status"], current["amount"]));
      }
      paidcashback = 0;
      pendingcashback = 0;
      processingcashback = 0;
      earnedCashback = 0;
      for (Cashback i in cashbacks) {
        if (i.status == "eligible") {
          pendingcashback += (i.amount as double);
        } else if (i.status == "processing") {
          processingcashback += (i.amount as double);
        } else if (i.status == "paid") {
          paidcashback += (i.amount as double);
        }

        earnedCashback = paidcashback + pendingcashback + processingcashback;
      }
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //spent = 0;
    getCashback();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cashback",
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
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: Text(
                        "Cashback Summary",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Earned Cashback till date",
                                    style: TextStyle(color: Color(0xff999999)),
                                  ),
                                  Text(
                                    "\$${earnedCashback.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Color(0xff3DBB85),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Redeemed Cashback",
                                    style: TextStyle(color: Color(0xff999999)),
                                  ),
                                  Text(
                                    "\$${paidcashback.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff292D32)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "In Process",
                                    style: TextStyle(color: Color(0xff999999)),
                                  ),
                                  Text(
                                    "\$${processingcashback.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff292D32)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Redeemable Cashback",
                                    style: TextStyle(color: Color(0xff999999)),
                                  ),
                                  Text(
                                    "\$${pendingcashback.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Color(0xff292D32)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: pendingcashback >= 10
                            ? const Text(
                                "Congratulations!",
                                style: TextStyle(
                                  color: Color(0xff3DBB85),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                "No Cashback Yet!",
                                style: TextStyle(
                                  color: Color(0xffFF6359),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    pendingcashback >= 10
                        ? const Text(
                            "You are eligible for a free delivery of your cashback check!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            ),
                          )
                        : const Text(
                            "You will be eligible for cashback as soon as you have ${10} or more as Redeemable cashback. Keep at it!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            ),
                          ),
                    pendingcashback >= 10
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: GestureDetector(
                              onTap: () {
                                requestCashback();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffFEC107),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                height: 50,
                                child: const Center(
                                  child: Text(
                                    "REQUEST CASHBACK!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const Expanded(child: SizedBox()),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hot Tips!!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color(0xffFF6359),
                                size: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Invite others and get cashback!")
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color(0xffFF6359),
                                size: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "Don't miss anything, scan everything at \nfood basics.")
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color(0xffFF6359),
                                size: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Check additional tips to save even more!")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        )
        // : const Center(
        //     child: Text("You're not eligible for the Cashback."),
        //   ),
        );
  }
}
