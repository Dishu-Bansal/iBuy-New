import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class ReceiptCard extends StatelessWidget {
  final String retailer;
  final String spend;
  final int date;
  final String status;
  final String url;
  final String reason;
  const ReceiptCard(
      {super.key,
      required this.retailer,
      required this.spend,
      required this.date,
      required this.status,
      required this.url,
      required this.reason,});

  @override
  Widget build(BuildContext context) {
    //calculate the date difference between today and the date of the receipt
    final dateDifference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(date))
        .inDays;

    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageNetwork(
                  image: url,
                  fitAndroidIos: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.cancel))
              ],
            ),
          );
        });
      },
      child: Padding(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(reason),
                      Text(dateDifference == 0
                          ? "Today"
                          : "$dateDifference days ago")
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
