import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/Screens/retailer_controller.dart';
import 'package:intl/intl.dart';

class RetailerDataSource extends DataTableSource {
  final retailerController = Get.find<RetailerController>();
  //create an obejct of intl class to format date
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      // DataCell(
      //   Obx(
      //     () => Checkbox(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(6),
      //         ),
      //         tristate: false,
      //         value: planController.checked[index],
      //         onChanged: (value) {
      //           planController.checked[index] = !planController.checked[index];

      //           if (planController.checkedPlans
      //               .contains(planController.plans[index].id.toString())) {
      //             planController.checkedPlans
      //                 .remove(planController.plans[index].id.toString());
      //           } else {
      //             planController.checkedPlans
      //                 .add(planController.plans[index].id.toString());
      //           }

      //           //accController.update();
      //         },
      //         activeColor: kPrimaryColor),
      //   ),
      // ),
      DataCell(Text(retailerController.retailers[index].count.toString())),
      DataCell(Text(retailerController.retailers[index].planName.toString())),
      DataCell(Text(retailerController.retailers[index].storeName.toString())),
      DataCell(Text(retailerController.retailers[index].startDate!)),
      DataCell(Text(retailerController.retailers[index].enddate.toString())),
      DataCell(
          Text(retailerController.retailers[index].maxCustomers.toString())),
      DataCell(
          Text("\$${retailerController.retailers[index].minSpend.toString()}")),
      DataCell(Text("\$${retailerController.retailers[index].maxSpend}")),
      DataCell(Text(
          "\$${retailerController.retailers[index].minCashback.toString()}")),
      DataCell(Text(
          "\$${retailerController.retailers[index].maxCashback.toString()}")),
      //DataCell(Text(retailerController.retailers[index].storeName.toString())),
      DataCell(Obx(
        () => Chip(
          label: Text(
            retailerController.retailers[index].status!,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor:
              retailerController.retailers[index].status! == "Active"
                  ? Color(0xff3DBB85)
                  : Color(0xff292D32),
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => retailerController.retailers.length;

  @override
  int get selectedRowCount => 0;
}
