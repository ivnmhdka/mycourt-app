import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycourt/services/HistoryServices.dart';

class HistoryController extends GetxController {
  final Historyservices _historyService = Historyservices();

  // Observables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<Map<String, dynamic>> bookings =
      <Map<String, dynamic>>[].obs;
  final RxString selectedFilter = 'all'.obs;

  // Filtered bookings
  List<Map<String, dynamic>> get filteredBookings {
    if (selectedFilter.value == 'all') {
      return bookings;
    }
    return bookings
        .where((booking) =>
            booking['status']?.toString().toUpperCase() ==
            selectedFilter.value.toUpperCase())
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _historyService.getUserBookings();
      bookings.value = data;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar(
        'Error',
        'Failed to load bookings: ${errorMessage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterByStatus(String status) {
    selectedFilter.value = status;
  }

  // Future<void> cancelBooking(String bookingId) async {
  //   try {
  //     isLoading.value = true;
  //     await _historyService.cancelBooking(bookingId);

  //     // Update local list
  //     final index = bookings.indexWhere((b) => b['id'] == bookingId);
  //     if (index != -1) {
  //       bookings[index]['status'] = 'CANCELLED';
  //       bookings.refresh();
  //     }

  //     Get.snackbar(
  //       'Success',
  //       'Booking cancelled successfully',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to cancel booking: $e',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void viewBookingDetails(String bookingId) {
    Get.toNamed('/booking-details', arguments: {'bookingId': bookingId});
  }
}