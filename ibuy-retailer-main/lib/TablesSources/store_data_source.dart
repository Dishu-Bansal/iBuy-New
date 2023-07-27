import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/models/plan_modal.dart';

import '../constants.dart';
import '../models/store_modal.dart';
import '../pages/view_add_store_controller.dart';

class StoreDataSource extends DataTableSource {
  final storeController = Get.find<ViewAddStoreController>();
  PlanModal? checkedplan;

  StoreDataSource(this.checkedplan);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Obx(
          () {
            StoreModal store = storeController.stores[index];
            return Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                tristate: checkedplan == null ? false : true,
                value: checkedplan == null
                    ? storeController.checked[index]
                    : ((checkedplan!.id == store.plan || store.plan == '')
                        ? storeController.checked[index]
                        : null),
                onChanged: (checkedplan == null ||
                        checkedplan!.id == store.plan ||
                        store.plan == '')
                    ? (value) {
                        storeController.checked[index] =
                            !storeController.checked[index];

                        if (storeController.checkedStores.contains(
                            storeController.stores[index].id.toString())) {
                          storeController.checkedStores.remove(
                              storeController.stores[index].id.toString());
                        } else {
                          storeController.checkedStores
                              .add(storeController.stores[index].id.toString());
                        }

                        //accController.update();
                      }
                    : null,
                activeColor: kPrimaryColor);
          },
        ),
      ),
      DataCell(Text(storeController.stores[index].storeCode.toString())),
      DataCell(Text(storeController.stores[index].storeName.toString())),
      DataCell(Text(storeController.stores[index].add1.toString())),
      DataCell(Text(storeController.stores[index].add2.toString())),
      DataCell(Text(storeController.stores[index].city.toString())),
      DataCell(Text(storeController.stores[index].province.toString())),
      DataCell(Text(storeController.stores[index].postalCode.toString())),
      DataCell(Text(storeController.stores[index].country.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => storeController.stores.length;

  @override
  int get selectedRowCount => 0;
}
