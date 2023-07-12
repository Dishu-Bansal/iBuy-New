import 'package:get/get.dart';

class SidebarController extends GetxController {
  var selectedIndex = 0.obs;

  int get selIndex => selectedIndex.value;

  void updateIndex(index) {
    selectedIndex.value = index;
  }
}
