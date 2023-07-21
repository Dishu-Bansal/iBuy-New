import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/pages/plan_controller.dart';
import 'package:ibuy_app_retailer_web/pages/view_add_store_controller.dart';

import '../TablesSources/store_data_source.dart';

List<String> selectedStores = List.empty(growable: true);

class AddPlan extends StatelessWidget {
  AddPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final planController = Get.put(PlanController());
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFormField(
                    controller: planController.startDateCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Start date (DD-MM-YYYY)",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: planController.endDateCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "End Date (DD-MM-YYYY)",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: planController.maxCustomersCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Max Customers",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.isNum) {
                        return "Field name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: planController.minSpendCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Spend Min",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.isNum == false) {
                        return "Incorrect Input";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: planController.maxSpendCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Spend Max",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.isNum) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: planController.minCashbackCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Cashback Min",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.isNum) {
                        return "Incorrect Input";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: planController.maxCashbackCon,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Cashback Max",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.isNum) {
                        return "Incorrect Input";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: planController.cashBack,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Cashback (%)",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.isNum == false) {
                        return "Incorrect input";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: planController.planName,
                    cursorColor: Colors.black45,
                    decoration: InputDecoration(
                      labelText: "Name your Plan",
                      //border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.black45),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Incorrect input";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            StoreSelection(),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  //width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            planController.addPlan(selectedStores);
                          } else {
                            //display error message with snackbar
                            Get.snackbar(
                                "Input error", "Please fill all the fields");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff35BF84),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "ADD Plan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff999999),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              "DISCARD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class StoreSelection extends StatefulWidget {
  const StoreSelection({Key? key}) : super(key: key);

  @override
  State<StoreSelection> createState() => _StoreSelectionState();
}

class _StoreSelectionState extends State<StoreSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () async {
            selectedStores = await showDialog(
                context: context,
                builder: (context) {
                  final storeController =
                      Get.put(ViewAddStoreController(), permanent: true);

                  final DataTableSource data = StoreDataSource();

                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 0),
                      child: FutureBuilder(
                        future: storeController.getStores(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 600,
                                    color: Colors.white,
                                    child: PaginatedDataTable2(
                                      //set the max pages to length of data

                                      rowsPerPage: 10,
                                      showFirstLastButtons: false,
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) =>
                                                  const Color(0xffF8F8F8)
                                                      .withOpacity(1)),
                                      columnSpacing: 12,

                                      horizontalMargin: 12,
                                      // showBottomBorder: true,
                                      // bottomMargin: 0,
                                      minWidth: 400,
                                      onPageChanged: (value) {},
                                      // decoration: BoxDecoration(
                                      //   border: Border.all(
                                      //     color: Colors.grey,
                                      //     width: 1,
                                      //   ),
                                      // ),
                                      columns: const [
                                        DataColumn2(
                                          label: Text(''),
                                        ),
                                        DataColumn2(
                                          label: Text('Store Code'),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn(
                                          label: Text('Store Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Address 1'),
                                        ),
                                        DataColumn(
                                          label: Text('Address 2'),
                                        ),
                                        DataColumn(
                                          label: Text('City'),
                                        ),
                                        DataColumn(
                                          label: Text('Province'),
                                        ),
                                        DataColumn(
                                          label: Text('Postal Code'),
                                        ),
                                        DataColumn(
                                          label: Text('Country'),
                                        ),
                                      ],
                                      source: data,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context,
                                        storeController.checkedStores
                                            .map((e) => e.toString())
                                            .toList());
                                  },
                                  color: const Color(0xff35BF84),
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  elevation: 0,
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  );
                });
            setState(() {});
          },
          child: Text(
            "Select Stores",
            style: TextStyle(color: Colors.white),
          ),
          color: const Color(0xff35BF84),
          elevation: 0,
        ),
        SizedBox(
          width: 15,
        ),
        Text(selectedStores.length.toString() + " stores selected"),
      ],
    );
  }
}
