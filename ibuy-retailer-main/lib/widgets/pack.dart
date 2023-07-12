import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Pack extends StatelessWidget {
  final String name;
  final Timestamp dateCreated;
  final double cashback;
  final bool isActive;
  final int users;

  const Pack(
      {super.key,
      required this.name,
      required this.dateCreated,
      required this.cashback,
      required this.isActive,
      required this.users});

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('MM/dd/yyyy');
    return Container(
      height: 230,
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
      child: Padding(
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
                        name,
                        style: _headingStyle(),
                      ),
                      const SizedBox(width: 10),
                      isActive
                          ? Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff3DBB85),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Active",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff292D32),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Disabled",
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
                        "No. of users Eneolled",
                        style: _subHeadingStyle(),
                      ),
                      Text(users.toString(), style: _smallHeading()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date Created",
                        style: _subHeadingStyle(),
                      ),
                      Text(f.format(dateCreated.toDate()).toString(),
                          style: _smallHeading()),
                    ],
                  ),
                ],
              ),
            ),
            SleekCircularSlider(
              innerWidget: (percentage) => Center(
                child: Text(
                  "\$${cashback.toString()}",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                  topLabelText: "\$${cashback.toString()}",
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
              min: 10,
              max: 100,
              initialValue: 50,
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
