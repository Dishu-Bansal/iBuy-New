import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../pages/view_add_store_controller.dart';

class StoreDataSource extends DataTableSource {
  final storeController = Get.find<ViewAddStoreController>();

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
              value: storeController.checked[index],
              onChanged: (value) {
                storeController.checked[index] =
                    !storeController.checked[index];

                if (storeController.checkedStores
                    .contains(storeController.stores[index].id.toString())) {
                  storeController.checkedStores
                      .remove(storeController.stores[index].id.toString());
                } else {
                  storeController.checkedStores
                      .add(storeController.stores[index].id.toString());
                }

                //accController.update();
              },
              activeColor: kPrimaryColor),
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
