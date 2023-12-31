import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/Screens/retailer_controller.dart';
import 'package:ibuy_admin_app/constants.dart';
import 'package:ibuy_admin_app/retailer_data_source.dart';

class RetailersPlansScreen extends StatelessWidget {
  const RetailersPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final retailerController = Get.put(RetailerController(), permanent: true);

    // print("len: " + storeController.accounts.length.toString());

    final DataTableSource data = RetailerDataSource();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: FutureBuilder(
        future: retailerController.getRetailers(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return retailerController.isLoading.value
                ? CircularProgressIndicator(
                    color: kPrimaryColor,
                  )
                : Column(
                    children: [
                      Flexible(
                        child: Container(
                          height: 400,
                          color: Colors.white,
                          child: PaginatedDataTable2(
                            //set the max pages to length of data

                            //calculate rows per page dynamically
                            rowsPerPage: 5,
                            dataRowHeight: 70,

                            showFirstLastButtons: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color(0xffF8F8F8).withOpacity(1)),
                            columnSpacing: 12,

                            horizontalMargin: 14,
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
                              // DataColumn2(
                              //   label: Text(''),
                              // ),
                              DataColumn2(
                                label: Text('Plan ID'),
                              ),
                              DataColumn2(
                                label: Text('Retailer'),
                              ),
                              DataColumn2(
                                label: Text('Start Date'),
                              ),
                              DataColumn(
                                label: Text('End Date'),
                              ),
                              DataColumn2(
                                label: Text('Customer Count'),
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
                              // DataColumn(
                              //   label: Text('Store'),
                              // ),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       //width: 200,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xff35BF84),
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             child: Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 15, vertical: 10),
                      //               child: GestureDetector(
                      //                 onTap: () {
                      //                   if (retailerController
                      //                       .checked.isEmpty) {
                      //                     //display erroe message with snackbar with Getx
                      //                     Get.snackbar(
                      //                       "Error",
                      //                       "Please select a Account to Approve",
                      //                       snackPosition: SnackPosition.BOTTOM,
                      //                       backgroundColor: Colors.red,
                      //                       colorText: Colors.white,
                      //                       margin: const EdgeInsets.all(8),
                      //                       borderRadius: 8,
                      //                       isDismissible: true,
                      //                       forwardAnimationCurve:
                      //                           Curves.fastLinearToSlowEaseIn,
                      //                     );
                      //                   } else {
                      //                     //retailerController.approveAccounts();
                      //                   }
                      //                 },
                      //                 child: Row(
                      //                   children: const [
                      //                     Text(
                      //                       "APPROVE",
                      //                       style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.w500,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(
                      //             width: 10,
                      //           ),
                      //           GestureDetector(
                      //             // onTap: () {
                      //             //   if (accController.checkedAccounts.isEmpty) {
                      //             //     //display erroe message with snackbar with Getx
                      //             //     Get.snackbar(
                      //             //       "Error",
                      //             //       "Please select a Account to Reject",
                      //             //       snackPosition: SnackPosition.BOTTOM,
                      //             //       backgroundColor: Colors.red,
                      //             //       colorText: Colors.white,
                      //             //       margin: const EdgeInsets.all(8),
                      //             //       borderRadius: 8,
                      //             //       isDismissible: true,
                      //             //       forwardAnimationCurve:
                      //             //           Curves.fastLinearToSlowEaseIn,
                      //             //     );
                      //             //   } else {
                      //             //     accController.rejectAccounts();
                      //             //   }
                      //             // },
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: const Color(0xffE64141),
                      //                 borderRadius: BorderRadius.circular(50),
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 15, vertical: 10),
                      //                 child: Row(
                      //                   children: const [
                      //                     Text(
                      //                       "REJECT",
                      //                       style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.w500),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  );
          }
        }),
      ),
    );
  }
}
