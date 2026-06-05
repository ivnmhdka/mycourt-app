import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppDashboardController extends GetxController {
  //TODO: Implement AppDashboardController
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var username = ''.obs;
  var isLoadingFields = true.obs;
  var popularFields = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
    getUsername();
    fetchPopularFields();
  }

  @override
  void onReady() async{
    super.onReady();
    checkAuthStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }

// Future<void> injectDummyFields() async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
//   // Ini adalah data ala JSON yang siap dikirim
//   List<Map<String, dynamic>> dummyData = [
//     {
//       "name": "Champions Futsal Arer",
//       "venueType": "Indoor",
//       "sportType": "Futsal",
//       "rating": 4.8,
//       "pricePerHour": 150000,
//       "imageUrl": "https://images.unsplash.com/photo-1574629810360-7efbb1925846?q=80&w=300&auto=format&fit=crop",
//       "createdAt": FieldValue.serverTimestamp(),
//     },
//     {
//       "name": "Smash Badminton Ha",
//       "venueType": "Indoor",
//       "sportType": "Badminton",
//       "rating": 4.6,
//       "pricePerHour": 75000,
//       "imageUrl": "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=300&auto=format&fit=crop",
//       "createdAt": FieldValue.serverTimestamp(),
//     },
//     {
//       "name": "Hoops Basketball Cou",
//       "venueType": "Indoor",
//       "sportType": "Basketball",
//       "rating": 4.9,
//       "pricePerHour": 200000,
//       "imageUrl": "https://images.unsplash.com/photo-1505666287802-931dc83948e9?q=80&w=300&auto=format&fit=crop",
//       "createdAt": FieldValue.serverTimestamp(),
//     }
//   ];

//   try {
//     // Looping data dan masukkan ke collection 'fields'
//     for (var field in dummyData) {
//       await firestore.collection('fields').add(field);
//     }
//     print("✅ Berhasil inject semua data ke Firestore!");
//   } catch (e) {
//     print("❌ Gagal inject data: $e");
//   }
// }

  void getUsername() {
    User? user = _auth.currentUser;
    if (user != null) {
      username.value = user.displayName ?? "User";
    } else {
      username.value = "Guest";
    }
  }

  void checkAuthStatus() {
    User? user = _auth.currentUser;
    if (user == null) {
      Get.offAllNamed('/login');
    }
  }

  Future<void> fetchPopularFields() async {
    try {
      isLoadingFields(true);
      
      QuerySnapshot querySnapshot = await _firestore.collection('fields').get();
      
      popularFields.value = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; 
        return data;
      }).toList();
      
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data lapangan: $e");
    } finally {
      isLoadingFields(false);
    }
  }

  Future<void> refreshDashboard() async {
    await fetchPopularFields();
  }
}
