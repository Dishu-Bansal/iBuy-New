import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ibuy_app_retailer_web/main-homepage-screens/packs_controller.dart';

import '../widgets/pack.dart';

class PacksScreen extends StatelessWidget {
  const PacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packsController = Get.put(PacksController());
    packsController.plans.clear();
    packsController.getPacks();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: AlignedGridView.count(
          itemCount: packsController.plans.length,
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
          itemBuilder: (context, index) {
            return Pack(
              plan: packsController.plans[index],
            );
          },
        ),
      ),
    );
  }
}
