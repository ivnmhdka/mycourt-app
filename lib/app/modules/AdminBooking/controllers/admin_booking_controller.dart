import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminBookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  var allBookings = <Map<String, dynamic>>[].obs;
  var filteredBookings = <Map<String, dynamic>>[].obs;
  
  var selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllBookings();
  }

  Future<void> fetchAllBookings() async {
    try {
      isLoading(true);
      
      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .orderBy('createdAt', descending: true)
          .get();

      var data = snapshot.docs.map((doc) {
        var docData = doc.data() as Map<String, dynamic>;
        docData['id'] = doc.id;
        return docData;
      }).toList();

      allBookings.value = data;
      applyFilter(selectedFilter.value); // Terapkan filter yang sedang aktif
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data booking: $e");
    } finally {
      isLoading(false);
    }
  }

  void applyFilter(String filter) {
    selectedFilter.value = filter;
    if (filter == 'All') {
      filteredBookings.value = allBookings;
    } else if (filter == 'Pending') {
      filteredBookings.value = allBookings.where((b) {
        String status = b['status'] ?? '';
        return status == 'PENDING' || status == 'PAID'; 
      }).toList();
    } else if (filter == 'Approved') {
      filteredBookings.value = allBookings.where((b) => b['status'] == 'APPROVED').toList();
    }
  }

  Future<void> updateBookingStatus(String id, String newStatus) async {
    try {
      await _firestore.collection('bookings').doc(id).update({'status': newStatus});
      
      // Update state lokal agar UI berubah instan
      int indexAll = allBookings.indexWhere((b) => b['id'] == id);
      if (indexAll != -1) {
        var updatedBooking = Map<String, dynamic>.from(allBookings[indexAll]);
        updatedBooking['status'] = newStatus;
        allBookings[indexAll] = updatedBooking;
      }
      
      // Re-apply filter agar list ter-refresh otomatis sesuai tab yang aktif
      applyFilter(selectedFilter.value);
      
      Get.snackbar("Sukses", "Booking berhasil di-$newStatus");
    } catch (e) {
      Get.snackbar("Error", "Gagal mengubah status: $e");
    }
  }

  void viewProof(String? proofUrl) {
    if (proofUrl == null || proofUrl.isEmpty) {
      Get.snackbar("Info", "Bukti pembayaran belum diunggah atau tidak tersedia.");
      return;
    }
    // Nanti bisa diarahkan ke halaman/dialog preview gambar
    Get.snackbar("View Proof", "Fitur preview bukti pembayaran akan ditampilkan di sini.");
  }
}