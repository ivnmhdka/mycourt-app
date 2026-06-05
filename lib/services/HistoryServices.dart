import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Historyservices extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUserBookings() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot historySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return historySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } else {
      throw Exception("No user is currently logged in.");
    }
  }
}
