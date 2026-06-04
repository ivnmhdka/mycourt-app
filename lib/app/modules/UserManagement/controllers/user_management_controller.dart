import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserManagementController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  var usersList = <Map<String, dynamic>>[].obs;
  var filteredUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      
      var data = snapshot.docs.map((doc) {
        var docData = doc.data() as Map<String, dynamic>;
        docData['id'] = doc.id;
        return docData;
      }).toList();

      usersList.value = data;
      filteredUsers.value = data;
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data user: $e");
    } finally {
      isLoading(false);
    }
  }

  void searchUser(String query) {
    if (query.isEmpty) {
      filteredUsers.value = usersList;
    } else {
      filteredUsers.value = usersList.where((user) {
        String name = (user['name'] ?? user['fullName'] ?? '').toLowerCase();
        String email = (user['email'] ?? '').toLowerCase();
        return name.contains(query.toLowerCase()) || email.contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      usersList.removeWhere((user) => user['id'] == id);
      filteredUsers.removeWhere((user) => user['id'] == id);
      Get.snackbar("Success", "User berhasil dihapus");
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus user: $e");
    }
  }
}