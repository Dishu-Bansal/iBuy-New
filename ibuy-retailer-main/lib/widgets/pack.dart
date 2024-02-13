import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Pack extends StatefulWidget {
  final PlanModal plan;

  const Pack({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  State<Pack> createState() => _PackState();
}

class _PackState extends State<Pack> {
  bool loading = true;
  double sales = 0;
  double cashback = 0;

  getInfo() async {
    await FirebaseFirestore.instance
        .collection("receipts")
        .where("plan_id", isEqualTo: widget.plan.id!)
        .where("status", isEqualTo: "approved")
        .get()
        .then((value) {
      for (DocumentSnapshot d in value.docs) {
        sales = sales + double.parse(d["totalSpend"]);
      }
    });
    await FirebaseFirestore.instance
        .collection("cashback")
        .where("planId", isEqualTo: widget.plan.id!)
        .where("status", isEqualTo: "paid")
        .get()
        .then((value) {
      for (DocumentSnapshot d in value.docs) {
        cashback = cashback + d["amount"];
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('MM/dd/yyyy');
    return Container(
      height: 300,
      width: 550,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        //give a grey box shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.plan.planName!,
                              style: _headingStyle(),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: widget.plan.status == "Active"
                                    ? const Color(0xff3DBB85)
                                    : const Color(0xff292D32),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  widget.plan.status!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No. of users Enrolled",
                              style: _subHeadingStyle(),
                            ),
                            Text(widget.plan.usersEnrolled.toString(),
                                style: _smallHeading()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date Created",
                              style: _subHeadingStyle(),
                            ),
                            Text(
                                f
                                    .format(widget.plan.creation!.toDate())
                                    .toString(),
                                style: _smallHeading()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customers Served",
                              style: _subHeadingStyle(),
                            ),
                            Text(widget.plan.served.toString(),
                                style: _smallHeading()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sales Generated",
                              style: _subHeadingStyle(),
                            ),
                            Text(sales.toString(), style: _smallHeading()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cashback Given",
                              style: _subHeadingStyle(),
                            ),
                            Text(cashback.toString(), style: _smallHeading()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SleekCircularSlider(
                    innerWidget: (percentage) => Center(
                      child: Text(
                        "${widget.plan.usersEnrolled.toString()}/${widget.plan.maxCustomers.toString()}",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        topLabelText:
                            "${widget.plan.usersEnrolled.toString()}/${widget.plan.maxCustomers.toString()}",
                        topLabelStyle: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        // modifier: (double value) {
                        //   return value.toInt().toString();
                        // },

                        bottomLabelText: "Cashback",
                        bottomLabelStyle: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      customWidths: CustomSliderWidths(
                          progressBarWidth: 10,
                          trackWidth: 10,
                          shadowWidth: 0,
                          handlerSize: 0),
                      customColors: CustomSliderColors(
                        progressBarColor: const Color(0xff3DBB85),
                        trackColor: const Color(0xffE5E5E5),
                      ),
                    ),
                    min: 0,
                    max: widget.plan.maxCustomers!.toDouble(),
                    initialValue: widget.plan.usersEnrolled!.toDouble(),
                  ),
                ],
              ),
            ),
    );
  }

  TextStyle _headingStyle() {
    return GoogleFonts.openSans(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle _smallHeading() {
    return GoogleFonts.openSans(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);
  }

  TextStyle _subHeadingStyle() {
    return GoogleFonts.openSans(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey);
  }
}
