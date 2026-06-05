import 'package:get/get.dart';
import 'package:mycourt/app/modules/history/controllers/history_controller.dart';
import 'package:mycourt/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/app_dashboard_controller.dart';

class AppDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDashboardController>(
      () => AppDashboardController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
