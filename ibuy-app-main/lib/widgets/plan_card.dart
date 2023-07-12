import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlanCard extends StatefulWidget {
  final String company;
  final String cashback;
  final String requiredSpend;
  final String endDate;
  final String retailerId;
  const PlanCard(
      {super.key,
      required this.company,
      required this.cashback,
      required this.requiredSpend,
      required this.endDate,
      required this.retailerId});

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  var retailerName = "";
  void getRetailerName(String retailerId) {
    print("Retailer ID: " + retailerId.toString());

    FirebaseFirestore.instance
        .collection("retailers")
        .doc(retailerId)
        .get()
        .then((value) {
      print("value" + value['retailer_name'].toString());
      setState(() {
        retailerName = value['retailer_name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getRetailerName(widget.retailerId);
    //var retailerName = getRetailerName(widget.retailerId);
    // print("retailerName" + retailerName);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xff292D32),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Required Spend",
                  style: TextStyle(color: Color(0xff999999)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "\$ ${widget.requiredSpend}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFEC107)),
                minHeight: 8,
                value: 1,
                color: Color(0xffFEC107),
                backgroundColor: Color(0xffE8E8E8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Plan end Date: ",
                  style: TextStyle(color: Color(0xff999999)),
                ),
                Text(
                  widget.endDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
