import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/cashback_controller.dart';
import 'package:ibuy_admin_app/cashback_data_source.dart';

class CashbackScreen extends StatelessWidget {
  const CashbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cashbackControllers = Get.put(CashbackController());
    final DataTableSource data = CashbackDatasource();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: FutureBuilder(
        future: cashbackControllers.getCashbacks(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Flexible(
                  child: Container(
                    height: 400,
                    color: Colors.white,
                    child: PaginatedDataTable2(
                      //set the max pages to length of data

                      //calculate rows per page dynamically
                      rowsPerPage: 5,

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
                        DataColumn2(
                          label: Text('Customer ID'),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text('Retailer'),
                        ),
                        DataColumn(
                          label: Text('Cashback Requested'),
                        ),
                        DataColumn(
                          label: Text('Status'),
                        ),
                      ],
                      source: data,
                    ),
                  ),
                ),
                //Add a button on the left side which says "Pay"
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff35BF84),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (cashbackControllers
                                      .checkedAccounts.isEmpty) {
                                    //display erroe message with snackbar with Getx
                                    Get.snackbar(
                                      "Error",
                                      "Please select a Cashback field.",
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
                                    cashbackControllers.pay();
                                  }
                                },
                                child: Row(
                                  children: const [
                                    Text(
                                      "PAY",
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
