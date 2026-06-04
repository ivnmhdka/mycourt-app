import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Map<String, dynamic> fieldData;

  var selectedDate = DateTime.now().obs;
  var isLoadingSlots = false.obs;
  var selectedSlot = ''.obs; 

  final List<String> timeSlots = [
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
  ];

  var bookedSlots = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fieldData = Get.arguments;
      fetchBookedSlots();
    }
  }

  String get formattedSelectedDate => DateFormat('yyyy-MM-dd').format(selectedDate.value);

  Future<void> fetchBookedSlots() async {
    try {
      isLoadingSlots(true);
      selectedSlot.value = ''; 
      
      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('fieldId', isEqualTo: fieldData['id'])
          .where('date', isEqualTo: formattedSelectedDate)
          .where('status', isEqualTo: 'APPROVED') 
          .get();

      List<String> booked = snapshot.docs.map((doc) {
        return (doc.data() as Map<String, dynamic>)['slot'] as String;
      }).toList();

      bookedSlots.value = booked;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengecek ketersediaan jadwal: $e");
    } finally {
      isLoadingSlots(false);
    }
  }

  void changeSelectedDate(DateTime date) {
    selectedDate.value = date;
    fetchBookedSlots(); 
  }

  void goToCheckout() {
    if (selectedSlot.value.isEmpty) {
      Get.snackbar("Pemberitahuan", "Silakan pilih slot jam terlebih dahulu");
      return;
    }

    Map<String, dynamic> checkoutData = {
      'fieldData': fieldData,
      'selectedDate': selectedDate.value, 
      'formattedDate': formattedSelectedDate, 
      'selectedSlot': selectedSlot.value,
      'price': fieldData['pricePerHour'],
    };

    Get.toNamed('/checkout', arguments: checkoutData);
  }
}