import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/pages/plan_controller.dart';

import '../constants.dart';

class PlanDataSource extends DataTableSource {
  final planController = Get.find<PlanController>();

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
              value: planController.checked[index],
              onChanged: (value) {
                planController.checked[index] = !planController.checked[index];

                if (planController.checkedPlans
                    .contains(planController.plans[index].id.toString())) {
                  planController.checkedPlans
                      .remove(planController.plans[index].id.toString());
                } else {
                  planController.checkedPlans
                      .add(planController.plans[index].id.toString());
                }

                //accController.update();
              },
              activeColor: kPrimaryColor),
        ),
      ),
      DataCell(Text(planController.plans[index].startDate.toString())),
      DataCell(Text(planController.plans[index].enddate.toString())),
      DataCell(Text(planController.plans[index].maxCustomers.toString())),
      DataCell(Text(planController.plans[index].minSpend.toString())),
      DataCell(Text(planController.plans[index].maxSpend.toString())),
      DataCell(Text(planController.plans[index].minCashback.toString())),
      DataCell(Text(planController.plans[index].maxCashback.toString())),
      DataCell(Text(planController.plans[index].storeName.toString())),
      DataCell(Obx(
        () => planController.plans[index].status!
            ? const Chip(
                label: Text(
                  "Active",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xff3DBB85),
              )
            : const Chip(
                label: Text(
                  "Disabled",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xff292D32),
              ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => planController.plans.length;

  @override
  int get selectedRowCount => 0;
}
