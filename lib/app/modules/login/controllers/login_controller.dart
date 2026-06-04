import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycourt/services/AuthServices.dart';

class LoginController extends GetxController {
  final Authservices _authService = Get.find<Authservices>();
  var rememberMe = false.obs;
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void handleLogin() async {
    try {
      isLoading.value = true;
      await _authService.login(emailController.text.trim(), passwordController.text.trim());
      Get.offAllNamed('/app-dashboard');
    } catch (e) {
      print("error: ${e.toString()}");
      if (e.toString().contains("invalid-credential")) {
        Get.snackbar("Login Failed", "Invalid email or password.");
      } else if (e.toString().contains("wrong-password")) {
        Get.snackbar("Login Failed", "Wrong password provided for that user.");
      } else {
        Get.snackbar("Our System is Down", "Please try again later.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void checkInput() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }
    handleLogin();
  } 


}
