import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  
  // Statistik
  var pendingBookings = '0'.obs;
  var todayBookings = '0'.obs;
  var todayRevenueFormatted = 'Rp 0'.obs;

  // List 3 Booking Terbaru
  var recentBookingsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading(true);
      
      String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

      QuerySnapshot recentSnapshot = await _firestore
          .collection('bookings')
          .orderBy('createdAt', descending: true)
          .limit(3)
          .get();

      recentBookingsList.value = recentSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      AggregateQuerySnapshot pendingSnap = await _firestore
          .collection('bookings')
          .where('status', whereIn: ['PENDING', 'PAID']) 
          .count()
          .get();
      pendingBookings.value = pendingSnap.count.toString();

      QuerySnapshot todaySnapshot = await _firestore
          .collection('bookings')
          .where('date', isEqualTo: todayStr)
          .get();

      todayBookings.value = todaySnapshot.docs.length.toString();
      
      double revenue = 0;
      for (var doc in todaySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        revenue += (data['price'] ?? 0);
      }
      
      todayRevenueFormatted.value = _formatRevenue(revenue);

    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data dashboard: $e");
    } finally {
      isLoading(false);
    }
  }

  String _formatRevenue(double amount) {
    if (amount >= 1000000) {
      return "Rp ${(amount / 1000000).toStringAsFixed(1).replaceAll('.0', '')}M";
    } else if (amount >= 1000) {
      return "Rp ${(amount / 1000).toStringAsFixed(0)}K";
    }
    return "Rp ${amount.toStringAsFixed(0)}";
  }

  Future<void> updateBookingStatus(String id, String newStatus) async {
    try {
      await _firestore.collection('bookings').doc(id).update({'status': newStatus});
      
      int index = recentBookingsList.indexWhere((b) => b['id'] == id);
      if (index != -1) {
        var updatedBooking = Map<String, dynamic>.from(recentBookingsList[index]);
        updatedBooking['status'] = newStatus;
        recentBookingsList[index] = updatedBooking;
      }

      if (newStatus != 'PENDING' && newStatus != 'PAID') {
        int currentPending = int.tryParse(pendingBookings.value) ?? 0;
        if (currentPending > 0) {
          pendingBookings.value = (currentPending - 1).toString();
        }
      }

      Get.snackbar("Sukses", "Status booking berhasil diubah menjadi $newStatus");
    } catch (e) {
      Get.snackbar("Error", "Gagal mengubah status: $e");
    }
  }
}