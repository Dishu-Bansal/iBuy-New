import 'package:flutter/material.dart';

class ReceiptCard extends StatelessWidget {
  final String retailer;
  final String spend;
  final String date;
  final String status;
  const ReceiptCard(
      {super.key,
      required this.retailer,
      required this.spend,
      required this.date,
      required this.status});

  @override
  Widget build(BuildContext context) {
    //calculate the date difference between today and the date of the receipt
    final dateDifference =
        DateTime.now().difference(DateTime.parse(date)).inDays;

    return Padding(
        padding: spend.isNotEmpty
            ? const EdgeInsets.only(bottom: 10)
            : const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("$retailer - ",
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    Text("\$$spend",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    //display a custom chip based on the status of the receipt
                    status == "reupload"
                        ? const Chip(
                            label: Text(
                              "Re Upload",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.orange,
                          )
                        : status == "approved"
                            ? const Chip(
                                label: Text(
                                  "Approved",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              )
                            : status == "rejected"
                                ? const Chip(
                                    label: Text(
                                      "Rejected",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  )
                                : const Chip(
                                    label: Text(
                                      "Submitted. Pending Review",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(dateDifference == 0
                        ? "Today"
                        : "$dateDifference days ago")
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
