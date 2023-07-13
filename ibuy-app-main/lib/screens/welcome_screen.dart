import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/authentication/create_account_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Image.asset("assets/welcome_ballons.png")),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Welcome 🙏",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Text(
                  "Save BIG on Groceries with iBUY",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CreateAccountScreen()));
                    /*showModalBottomSheet<dynamic>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => const CreateAccountWidget());*/
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFEC107),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Center(
                        child: Text(
                      /*"GET STARTED"*/ "CREATE ACCOUNT",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () =>
                      AppRoutes.push(context, const CreateAccountScreen()),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Center(
                        child: Text(
                      "SIGN IN",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
