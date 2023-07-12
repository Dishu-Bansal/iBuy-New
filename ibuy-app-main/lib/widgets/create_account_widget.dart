import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/plan_status_screen.dart';

import '../authentication/create_account_screen.dart';

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.cancel)),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(25),
          child: Text(
            "Find the BEST GROCERY SAVINGS \nnear you",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const CreateAccountScreen()));
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
                  "CREATE ACCOUNT",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        MayBeLaterButton(),
      ],
    );
  }
}

class MayBeLaterButton extends StatefulWidget {
  MayBeLaterButton({Key? key}) : super(key: key);

  @override
  State<MayBeLaterButton> createState() => _MayBeLaterButtonState();
}

class _MayBeLaterButtonState extends State<MayBeLaterButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: InkWell(
        onTap: () async {
          if (!loading) {
            setState(() {
              loading = true;
            });
            UserCredential temp_user =
                await FirebaseAuth.instance.signInAnonymously();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PlanStatusScreen()));
          }
        },
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
          child: Center(
            child: loading
                ? const CircularProgressIndicator()
                : const Text(
                    "MAYBE LATER",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
          ),
        ),
      ),
    );
  }
}
