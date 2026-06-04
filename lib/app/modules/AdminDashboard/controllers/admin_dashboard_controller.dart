import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var totalUsers = '0'.obs;
  var activeManagers = '0'.obs;
  var totalFields = '0'.obs;
  var totalBookings = '0'.obs;
  
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    try {
      isLoading(true);
      
      final NumberFormat formatter = NumberFormat('#,##0');

      final usersSnapshot = await _firestore.collection('users').count().get();
      final managersSnapshot = await _firestore.collection('users').where('role', isEqualTo: 'manager').count().get();
      final fieldsSnapshot = await _firestore.collection('fields').count().get();
      final bookingsSnapshot = await _firestore.collection('bookings').count().get();

      totalUsers.value = formatter.format(usersSnapshot.count ?? 0);
      activeManagers.value = formatter.format(managersSnapshot.count ?? 0);
      totalFields.value = formatter.format(fieldsSnapshot.count ?? 0);
      totalBookings.value = formatter.format(bookingsSnapshot.count ?? 0);

    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data statistik: $e");
    } finally {
      isLoading(false);
    }
  }
}