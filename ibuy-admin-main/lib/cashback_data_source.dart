import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/cashback_controller.dart';

import '../constants.dart';

class CashbackDatasource extends DataTableSource {
  final cashbackController = Get.find<CashbackController>();

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Obx(
          () => Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              tristate: false,
              value: cashbackController.checked[index],
              onChanged: (value) {
                cashbackController.checked[index] =
                    !cashbackController.checked[index];

                if (cashbackController.checkedAccounts.contains(
                    cashbackController.cashbacks[index].id.toString())) {
                  cashbackController.checkedAccounts.remove(
                      cashbackController.cashbacks[index].id.toString());
                } else {
                  cashbackController.checkedAccounts
                      .add(cashbackController.cashbacks[index].id.toString());
                }
                print(cashbackController.checkedAccounts);

                //accController.update();
              },
              activeColor: kPrimaryColor),
        ),
      ),
      DataCell(Text(cashbackController.cashbacks[index].uid.toString())),
      DataCell(Text(cashbackController.cashbacks[index].retailer.toString())),
      DataCell(
          Text("\$${cashbackController.cashbacks[index].amount.toString()}")),
      DataCell(
        //if the status is "new", return a chip with purple background with text "new", if the status is "approved", return a chip with green background with text "approved" and if the status is "rejected", return a chip with red background with text "rejected"
        cashbackController.cashbacks[index].status == null
            ? const Chip(
                label: Text("Working"),
              )
            : Obx(
                () => cashbackController.cashbacks[index].status!
                    ? const Chip(
                        backgroundColor: Color(0xff35BF84),
                        label: Text(
                          "Paid",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : const Chip(
                        backgroundColor: Color(0xffE64141),
                        label: Text(
                          "Unpaid",
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
  int get rowCount => cashbackController.cashbacks.length;

  @override
  int get selectedRowCount => 0;
}
