import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/get_location_widget.dart';

class GroceryBudgetScreen extends StatefulWidget {
  const GroceryBudgetScreen({super.key});

  @override
  State<GroceryBudgetScreen> createState() => _GroceryBudgetScreenState();
}

class _GroceryBudgetScreenState extends State<GroceryBudgetScreen> {
  final _formKey = GlobalKey<FormState>();

  final budgetController = TextEditingController();

  void savebudget(BuildContext context) async {
    final currentContext = context;

    //get the value from the text field
    if (_formKey.currentState!.validate()) {
      final budget = budgetController.text;

      Map<String, dynamic> data = {
        "budget": double.parse(budget),
      };
      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data)
          .then((value) => {
                showModalBottomSheet<dynamic>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  isScrollControlled: true,
                  context: currentContext,
                  builder: (context) => const GetLocationWidget(),
                )
              });

      //Show the bottom sheet and get the location
    } else {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(
          content: const Text(
            "Input all the fields!",
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return Scaffold(
      //drawer: const DrawerWidget(),
      appBar: AppBar(
        // leading: Builder(
        //   builder: (context) => (IconButton(
        //     icon: Image.asset("assets/drawer_icon.png"),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   )),
        // ),
        title: const Text(
          "Grocery Budget",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        bottomOpacity: 2,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: budgetController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.money_dollar,
                    color: Colors.black,
                  ),
                  labelText: "Enter your Monthly Grocery Budget?",
                  //border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle: const TextStyle(color: Colors.black45),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount cannot be empty";
                  }
                  return null;
                },
              ),
              InkWell(
                onTap: () => showModalBottomSheet<dynamic>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const GetLocationWidget(),
                ),
                child: InkWell(
                  onTap: () => savebudget(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFEC107),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
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
