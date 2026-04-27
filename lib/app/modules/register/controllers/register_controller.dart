import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycourt/services/AuthServices.dart';

class RegisterController extends GetxController {
  final Authservices _authService = Get.find<Authservices>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void handleRegister() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }
    try {
      isLoading.value = true;
      await _authService.register(emailController.text, passwordController.text);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Registration Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void checkInput() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }
    handleRegister();
  }

}
