import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycourt/services/AuthServices.dart';

class ProfileController extends GetxController {
  final Authservices _profileService = Authservices();

  // Observables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<String, dynamic> _userData = <String, dynamic>{}.obs;
  final RxString userRole = ''.obs;

  // Getters
  Map<String, dynamic> get userData => _userData;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Fetch user data from service
      final data = await _profileService.getProfileData();

      _userData.value = data;

      // Extract role
      userRole.value = data['role'] ?? 'user';

      // Handle any missing fields
      if (!_userData.containsKey('email')) {
        _userData['email'] = 'Not provided';
      }
      if (!_userData.containsKey('fullName')) {
        _userData['fullName'] = 'User';
      }
      if (!_userData.containsKey('phone')) {
        _userData['phone'] = 'Not provided';
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar(
        'Error',
        'Failed to load profile: ${errorMessage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _profileService.logout();

      // Clear local data
      _userData.clear();
      userRole.value = '';

      // Navigate to login
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}