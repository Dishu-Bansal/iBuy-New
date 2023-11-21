import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';
import 'package:freelance_ibuy_app/widgets/receipt_card.dart';

class RecieptsScreen extends StatefulWidget {
  const RecieptsScreen({super.key});

  @override
  State<RecieptsScreen> createState() => _RecieptsScreenState();
}

class _RecieptsScreenState extends State<RecieptsScreen> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> receipts = [];
  bool isLoading = false;

  @override
  void initState() {
    getReceipts();
    super.initState();
  }

  void getReceipts() {
    print(Userr().uid);
    print(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('receipts')
        .where("user_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print(value.docs);
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dat = value.docs;
      dat.sort((a, b) => b["update_time"] - a["update_time"]);
      if (dat.isNotEmpty) {
        setState(() {
          receipts = dat;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Receipts",
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
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: receipts.isEmpty
                        ? const Text("No receipts to show.")
                        : const Text(
                            "You can see the receipt amount once it is approved."),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ReceiptCard(
                          retailer: receipts[index]["retailerName"],
                          spend: receipts[index]["totalSpend"],
                          date: receipts[index]["update_time"],
                          status: receipts[index]["status"],
                        );
                      },
                      itemCount: receipts.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
