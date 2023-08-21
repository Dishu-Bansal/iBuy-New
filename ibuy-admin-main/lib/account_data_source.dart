import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/Screens/account_controller.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class AccountsDataSource extends DataTableSource {
  final accController = Get.find<AccountController>();

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
              value: accController.checked[index],
              onChanged: (value) {
                accController.checked[index] = !accController.checked[index];

                if (accController.checkedAccounts
                    .contains(accController.accounts[index].accId.toString())) {
                  accController.checkedAccounts
                      .remove(accController.accounts[index].accId.toString());
                } else {
                  accController.checkedAccounts
                      .add(accController.accounts[index].accId.toString());
                }
                print(accController.checkedAccounts);

                //accController.update();
              },
              activeColor: kPrimaryColor),
        ),
      ),
      DataCell(Text(accController.accounts[index].firstName.toString() +
          " " +
          accController.accounts[index].lastName.toString())),
      DataCell(Text(accController.accounts[index].email.toString())),
      DataCell(Text(accController.accounts[index].retailerName.toString())),
      DataCell(
        //if the status is "new", return a chip with purple background with text "new", if the status is "approved", return a chip with green background with text "approved" and if the status is "rejected", return a chip with red background with text "rejected"
        Obx(() => accController.accounts[index].status! != null
            ? (accController.accounts[index].status!
                ? const Chip(
                    backgroundColor: Color(0xff35BF84),
                    label: Text(
                      "Approved",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const Chip(
                    backgroundColor: Color.fromARGB(255, 239, 8, 66),
                    label: Text(
                      "Rejected",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            : const Chip(
                backgroundColor: Colors.orangeAccent,
                label: Text(
                  "New Request",
                  style: TextStyle(color: Colors.white),
                ),
              )),
      ),
      DataCell(Text(accController.accounts[index].plans!
          .where((element) => element.status == true)
          .length
          .toString())),
      DataCell(Text(DateFormat("dd/MM/yyyy")
          .format(DateTime.fromMillisecondsSinceEpoch(
              accController.accounts[index].creationDate!))
          .toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => accController.accounts.length;

  @override
  int get selectedRowCount => 0;
}
