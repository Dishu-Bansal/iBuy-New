import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';

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

  double earnedCashback = 0;
  void getReceipts() {
    spent = 0;
    print(Userr().uid);
    FirebaseFirestore.instance
        .collection('receipts')
        .where("user_uid", isEqualTo: Userr().uid.toString())
        .where("status", isEqualTo: "approved")
        .get()
        .then((value) {
      for (var element in value.docs) {
        spent += int.parse(element.data()['totalSpend']);
        retailer = element.data()['retailerName'];
      }

      print("spent: " + spent.toString());
      print("budget: " + Userr.userData.budget.toString());
    });

    if (spent > Userr.userData.budget) {
      setState(() {
        isEligible = true;
      });
    }
  }

  //get the total earned cashback till date
  void getTotalEarnedCashback() {
    FirebaseFirestore.instance
        .collection('cashbacks')
        .where("user_uid", isEqualTo: Userr().uid.toString())
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['paid'] == false) {
          //the cashback which is requested but not paid yet
          inProcessCashback += element.data()['amount'];
        } else {
          earnedCashback += element.data()['amount'];
          redemableCashback += element.data()['amount'];
        }
      }

      print("earnedCashback: " + earnedCashback.toString());
      print("inProcess: " + inProcessCashback.toString());
    });
  }

  void requestCashback() {
    FirebaseFirestore.instance.collection('cashbacks').add({
      "user_uid": Userr().uid,
      "amount": cashback / 100 * spent,
      "paid": false,
      "retailer": retailer,
      "date": DateTime.now().toString()
    }).then((value) => {
          //display success message with snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cashback requested successfully"),
            ),
          )
        });

    setState(() {
      getPlanDetails();
      getReceipts();
      getTotalEarnedCashback();
      checkIfAlreadyRequested();
      checkIfCashbackPaid();
    });
  }

  //a function that will check if a user has alraedy requested for cashback
  void checkIfAlreadyRequested() {
    FirebaseFirestore.instance
        .collection('cashbacks')
        .where("user_uid", isEqualTo: Userr().uid.toString())
        .where("paid", isEqualTo: false)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        //if the user has already requested for cashback
        setState(() {
          alreadyApplied = true;
        });
      }
    });
  }

  //a funtion that will check if the cashback is paid or not
  void checkIfCashbackPaid() {
    FirebaseFirestore.instance
        .collection('cashbacks')
        .where("user_uid", isEqualTo: Userr().uid.toString())
        .where("paid", isEqualTo: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        //if the user has already requested for cashback
        setState(() {
          casbackPaid = true;
        });
      }
    });
  }

  void getPlanDetails() {
    cashback = 0;
    FirebaseFirestore.instance
        .collection('plans')
        .doc(Userr().planId.toString())
        .get()
        .then((value) {
      requiredSpend = value.data()!['required_spend'];
      cashback = double.parse(value.data()!['cashback'].toString());
      retailer = value.data()!['company'];
      print("cashback" + cashback.toString());
      print("required spend:" + requiredSpend.toString());

      setState(() {});
    });
  }

  @override
  void initState() {
    getPlanDetails();
    getReceipts();
    getTotalEarnedCashback();
    checkIfAlreadyRequested();
    checkIfCashbackPaid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //spent = 0;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Text(
                  "Cashback Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      offset: const Offset(0, 1), // changes position of shadow
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Earned Cashback till date",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Text(
                              "\$${(cashback / 100 * spent).toStringAsFixed(2)}",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Redeemed Cashback",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Text(
                              "\$$redemedCashback",
                              style: const TextStyle(color: Color(0xff292D32)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "In Process",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Text(
                              !casbackPaid
                                  ? "\$${inProcessCashback.toStringAsFixed(2)}"
                                  : "\$0",
                              style: const TextStyle(color: Color(0xff292D32)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Redeemable Cashback",
                              style: TextStyle(color: Color(0xff999999)),
                            ),
                            Text(
                              !casbackPaid
                                  ? "\$$redemableCashback"
                                  : "\$${(cashback / 100 * spent).toStringAsFixed(2)}",
                              style: const TextStyle(color: Color(0xff292D32)),
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
                  child: spent >= Userr.userData.budget
                      ? !alreadyApplied
                          ? const Text(
                              "Congratulations!",
                              style: TextStyle(
                                color: Color(0xff3DBB85),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              !casbackPaid
                                  ? "Cashback already requested!"
                                  : "Cashback Approved!",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 29, 30, 30),
                                fontSize: 22,
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
              spent >= Userr.userData.budget
                  ? !casbackPaid
                      ? Text(
                          !alreadyApplied
                              ? "You are eligible for a free delivery of your cashback check!"
                              : "Please wait while we process your cashback request. You will be notified once your cashback is ready to be redeemed.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xff000000),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Your cashback has been approved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            ),
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
              spent >= Userr.userData.budget
                  ? !alreadyApplied && !casbackPaid
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
                      : const SizedBox()
                  : const SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hot Tips!!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: const [
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: const [
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: const [
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
