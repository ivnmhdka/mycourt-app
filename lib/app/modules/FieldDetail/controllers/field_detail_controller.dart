import 'package:get/get.dart';

class FieldDetailController extends GetxController {
  //TODO: Implement FieldDetailController
  var fieldData = {}.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fieldData.value = Get.arguments;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
