import 'package:get/get.dart';

import '../controllers/field_detail_controller.dart';

class FieldDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FieldDetailController>(
      () => FieldDetailController(),
    );
  }
}
