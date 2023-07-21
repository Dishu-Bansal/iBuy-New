import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/TablesSources/plan_data_source.dart';
import 'package:ibuy_app_retailer_web/constants.dart';
import 'package:ibuy_app_retailer_web/pages/add_plan.dart';
import 'package:ibuy_app_retailer_web/pages/edit_plans.dart';
import 'package:ibuy_app_retailer_web/pages/plan_controller.dart';

class CashBackPlans extends StatelessWidget {
  const CashBackPlans({super.key});

  @override
  Widget build(BuildContext context) {
    final planController = Get.put(PlanController(), permanent: true);

    final DataTableSource data = PlanDataSource();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: FutureBuilder(
        future: planController.getPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xffF8F8F8).withOpacity(1)),
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
                        DataColumn2(label: Text('Name')),
                        DataColumn2(
                          label: Text('Start Date'),
                        ),
                        DataColumn(
                          label: Text('End Date'),
                        ),
                        DataColumn(
                          label: Text('Max Customers'),
                        ),
                        DataColumn(
                          label: Text('Min Spend'),
                        ),
                        DataColumn(
                          label: Text('Max Spend'),
                        ),
                        DataColumn(
                          label: Text('Min Cashback'),
                        ),
                        DataColumn(
                          label: Text('Max Cashback'),
                        ),
                        DataColumn(
                          label: Text('Status'),
                        ),
                      ],
                      source: data,
                    ),
                  ),
                ),
                //Add a row with 3 containars. All containars will have Icon Buttons. first two buttons will be on the left side and the last button will be on the right side.
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      //width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffE64141),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (planController.checkedPlans.isEmpty) {
                                    //display erroe message with snackbar with Getx
                                    Get.snackbar(
                                      "Error",
                                      "Please select a plan to delete",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(8),
                                      borderRadius: 8,
                                      isDismissible: true,
                                      forwardAnimationCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                    );
                                  } else {
                                    //delete the selected stores
                                    planController.deletePlans();
                                    //storeController.update();
                                  }
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "DELETE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (planController.checkedPlans.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please select a plan to edit",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(8),
                                  borderRadius: 8,
                                  isDismissible: true,
                                  forwardAnimationCurve:
                                      Curves.fastLinearToSlowEaseIn,
                                );
                              } else {
                                //delete the selected stores
                                Get.to(() => const EditPlan());
                                //storeController.update();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff9D87FF),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, color: Colors.white),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "EDIT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (planController.checkedPlans.isEmpty) {
                                //display erroe message with snackbar with Getx
                                Get.snackbar(
                                  "Error",
                                  "Please select a plan to activate",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(8),
                                  borderRadius: 8,
                                  isDismissible: true,
                                  forwardAnimationCurve:
                                      Curves.fastLinearToSlowEaseIn,
                                );
                              } else {
                                //delete the selected stores
                                planController.activatePlans();
                                //storeController.update();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: const [
                                    Text(
                                      "ACTIVATE",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (planController.checkedPlans.isEmpty) {
                                //display erroe message with snackbar with Getx
                                Get.snackbar(
                                  "Error",
                                  "Please select a plan to activate",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(8),
                                  borderRadius: 8,
                                  isDismissible: true,
                                  forwardAnimationCurve:
                                      Curves.fastLinearToSlowEaseIn,
                                );
                              } else {
                                //delete the selected stores
                                planController.deactivatePlans();
                                //storeController.update();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: const [
                                    Text(
                                      "DEACTIVATE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //storeController.showStoreList.value = false;
                        Get.to(() => AddPlan());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff35BF84),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: const [
                              Icon(Icons.add, color: Colors.white),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "ADD PLAN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
