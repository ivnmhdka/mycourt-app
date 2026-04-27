import 'package:get/get.dart';
import 'package:mycourt/services/AuthServices.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put<Authservices>(Authservices(), permanent: true);
  }
}
