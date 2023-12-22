import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Head extends StatelessWidget {
  final String name;
  final String retailer;
  const Head({
    super.key,
    required this.name,
    required this.retailer,
  });

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
                  retailer,
                  style: GoogleFonts.openSans(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                // SizedBox(
                //   width: 380,
                //   child: TextFormField(
                //     controller: null,
                //     cursorColor: Colors.black45,
                //     decoration: InputDecoration(
                //       labelText: "Search",
                //       //border: OutlineInputBorder(),
                //       fillColor: Colors.white,
                //       filled: true,
                //       labelStyle: const TextStyle(color: Colors.black45),
                //       suffixIcon: const Icon(Icons.search),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(35.0),
                //         borderSide: const BorderSide(
                //           color: Colors.grey,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(35.0),
                //         borderSide: const BorderSide(
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Password cannot be empty";
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Row(
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
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
