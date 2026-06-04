import 'package:get/get.dart';

import '../controllers/app_dashboard_controller.dart';

class AppDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDashboardController>(
      () => AppDashboardController(),
    );
  }
}
