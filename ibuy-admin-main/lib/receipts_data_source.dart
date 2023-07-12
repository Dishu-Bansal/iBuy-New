import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/receipt_controller.dart';

class ReceiptsDataSource extends DataTableSource {
  final receiptController = Get.find<ReceiptController>();

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(receiptController.receiptModals[index].id.toString())),
      DataCell(
          Text(receiptController.receiptModals[index].retailerName.toString())),
      DataCell(Text(receiptController.receiptModals[index].userId.toString())),
      const DataCell(Text("")),
      DataCell(Text(receiptController.receiptModals[index].trxDate.toString())),

      //DataCell(Text(receiptController.receiptModals[index].userId.toString())),

      DataCell(
        //if the status is "new", return a chip with purple background with text "new", if the status is "approved", return a chip with green background with text "approved" and if the status is "rejected", return a chip with red background with text "rejected"
        Obx(
          () => receiptController.receiptModals[index].status! == "approved"
              ? const Chip(
                  backgroundColor: Color(0xff3DBB85),
                  label: Text(
                    "Approved",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : receiptController.receiptModals[index].status! == "reupload"
                  ? const Chip(
                      backgroundColor: Color.fromARGB(255, 232, 133, 46),
                      label: Text(
                        "Re Upload Required",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : receiptController.receiptModals[index].status! == ""
                      ? const Chip(
                          backgroundColor: Color(0xff6F6F6F),
                          label: Text(
                            "New",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : const Chip(
                          backgroundColor: Color(0xffE64141),
                          label: Text(
                            "Rejected",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => receiptController.receiptModals.length;

  @override
  int get selectedRowCount => 0;
}
