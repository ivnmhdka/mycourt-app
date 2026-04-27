import 'package:get/get.dart';
import 'package:mycourt/services/AuthServices.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.put<Authservices>(Authservices(), permanent: true);
  }
}
