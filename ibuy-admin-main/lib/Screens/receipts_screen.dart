import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/receipt_controller.dart';
import 'package:ibuy_admin_app/receipts_data_source.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receiptsController = Get.put(ReceiptController(), permanent: true);
    final DataTableSource data = ReceiptsDataSource();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: FutureBuilder(
        future: receiptsController.getReceiptModals(),
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
                          label: Text('Receipt ID'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Retailer ID'),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text('Customer ID'),
                        ),
                        DataColumn(
                          label: Text('Plan ID'),
                        ),
                        DataColumn(
                          label: Text('Submission Date'),
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
              ],
            );
          }
        }),
      ),
    );
  }
}
