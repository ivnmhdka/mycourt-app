import 'package:get/get.dart';

import '../controllers/sport_fields_controller.dart';

class SportFieldsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportFieldsController>(
      () => SportFieldsController(),
    );
  }
}
