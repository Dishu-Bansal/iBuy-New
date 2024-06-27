import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/pages/cashback_plans.dart';
import 'package:ibuy_app_retailer_web/pages/plan_controller.dart';
import 'package:ibuy_app_retailer_web/pages/view_add_store_controller.dart';
import 'package:intl/intl.dart';

import '../TablesSources/store_for_plan_data_source.dart';

List<String> selectedStores = List.empty(growable: true);
DateTime? startdate = null;
DateTime? enddate = null;
String startDate="", endDate="", minSpend="", maxSpend="", maxCust="", minCashback="", maxCashback="", cashback="", name = "";
final formKey = GlobalKey<FormState>();
final planController = Get.put(PlanController());
class AddPlan extends StatelessWidget {

  final startDateCon = TextEditingController();
  final endDateCon = TextEditingController();
  final storeNameCon = TextEditingController();
  final minSpendCon = TextEditingController();
  final maxSpendCon = TextEditingController();
  final maxCustomersCon = TextEditingController();
  final minCashbackCon = TextEditingController();
  final maxCashbackCon = TextEditingController();
  final cashBack = TextEditingController();
  final planName = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                    controller: startDateCon,
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
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 90)),
                      );
                      startdate = date;
                      startDateCon.text =
                          DateFormat('dd/MM/yyyy').format(date!).toString();
                      startDate =
                          DateFormat('dd/MM/yyyy').format(date!).toString();
                    },
                    onChanged: (value) {startDate = value;},
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
                    cursorColor: Colors.black45,
                    controller: endDateCon,
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
                    onChanged: (value) {endDate=value;},
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: startdate ?? DateTime.now(),
                        firstDate: startdate ?? DateTime.now(),
                        lastDate: startdate == null
                            ? DateTime.now().add(Duration(days: 90))
                            : startdate!.add(Duration(days: 90)),
                      );
                      enddate = date;
                      endDateCon.text =
                          DateFormat('dd/MM/yyyy').format(date!).toString();
                      endDate = DateFormat('dd/MM/yyyy').format(date!).toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      } else if (enddate!.difference(startdate!).inDays > 90 ||
                          enddate!.difference(startdate!).inDays <= 0) {
                        return "It must be within 90 days of start date";
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
                    onChanged: (value) {maxCust = value;},
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
                      } else if (int.parse(value) <= 0) {
                        return "Max Customers must have at least 1 value";
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
                    onChanged: (value) {minSpend=value;},
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
                    onChanged: (value) {maxSpend=value;},
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
                    onChanged: (value) {minCashback=value;},
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
                    onChanged: (value) {maxCashback=value;},
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
                    onChanged: (value) {cashback=value;},
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
                    onChanged: (value) {name=value;},
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
                      } else if (planController.plans
                          .any((element) => element.planName == value)) {
                        return "Same name plan already exists";
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
                      AddPlanButton(),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
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

class AddPlanButton extends StatefulWidget {
  const AddPlanButton({super.key});

  @override
  State<AddPlanButton> createState() => _AddPlanButtonState();
}

class _AddPlanButtonState extends State<AddPlanButton> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!loading)
          {
            setState(() {
              loading = true;
            });
            if (formKey.currentState!.validate()) {
              planController.addPlan(selectedStores, startDate, endDate, minSpend, maxSpend, maxCust, minCashback, maxCashback, cashback, name);
              Navigator.of(context).pop();
            } else {
              //display error message with snackbar
              Get.snackbar(
                  "Input error", "Please fill all the fields");
              setState(() {
                loading = false;
              });
            }
          }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff35BF84),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 10),
          child: loading ? Center(child: CircularProgressIndicator(),) : Text(
            "ADD Plan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
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

                  final DataTableSource data = StoreForPlanDataSource();

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
