import 'package:flutter/material.dart';
import 'package:ibuy_app_retailer_web/widgets/account_activation_fields.dart';
import 'package:ibuy_app_retailer_web/widgets/side_bg_widget.dart';

class AccountActivationPage extends StatelessWidget {
  final String email;
  final String retailer;
  const AccountActivationPage(
      {super.key, required this.email, required this.retailer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
              child: Builder(builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("iBuy_Retailer_Logo.png",
                        width: 200,
                        fit: BoxFit.cover,),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Email:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(email),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Retailer: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(retailer),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AccountActivationFields(
                        email: email,
                        retailer: retailer,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
