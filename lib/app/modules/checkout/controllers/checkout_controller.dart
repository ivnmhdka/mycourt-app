import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var checkoutData = {}.obs;
  var selectedPaymentMethod = ''.obs;
  var isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      checkoutData.value = Get.arguments;
    }
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> processPayment() async {
    if (selectedPaymentMethod.value.isEmpty) {
      Get.snackbar("Error", "Pilih metode pembayaran terlebih dahulu.");
      return;
    }

    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      isProcessing(true);
      
      var fieldData = checkoutData['fieldData'];
      
      await _firestore.collection('bookings').add({
        'fieldId': fieldData['id'],
        'fieldName': fieldData['name'],
        'userId': currentUser.uid,
        'date': checkoutData['formattedDate'],
        'slot': checkoutData['selectedSlot'],
        'price': checkoutData['price'],
        'paymentMethod': selectedPaymentMethod.value,
        'status': 'PENDING',
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.offAllNamed('/home'); 
      Get.snackbar("Payment Successful", "Jadwal lapangan berhasil dibooking!");
      
    } catch (e) {
      Get.snackbar("Payment Failed", e.toString());
    } finally {
      isProcessing(false);
    }
  }
}