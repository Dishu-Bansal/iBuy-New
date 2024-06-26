import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Head extends StatelessWidget {
  final String? name;
  const Head({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.maxFinite,
      //color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dashboard",
                  style: GoogleFonts.openSans(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "ibuy@admin.com",
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: null,
                      child: Icon(Icons.person),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name.toString(),
                  style: GoogleFonts.openSans(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 0),
            const Divider(color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
