import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SportFieldsController extends GetxController {
  //TODO: Implement SportFieldsController
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var fieldsList = <Map<String, dynamic>>[].obs;
  var filteredList = <Map<String, dynamic>>[].obs;

  var sportType = ''.obs;
  var selectedFilter = 'All'.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
    sportType.value = Get.arguments['sportType'] ?? 'Futsal'; 
    fetchFieldsBySport();
  }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchFieldsBySport() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _firestore
          .collection('fields')
          .where('sportType', isEqualTo: sportType.value)
          .get();

      var data = snapshot.docs.map((doc) {
        var docData = doc.data() as Map<String, dynamic>;
        docData['id'] = doc.id;
        return docData;
      }).toList();

      fieldsList.value = data;
      filteredList.value = data; 
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data: $e");
    } finally {
      isLoading(false);
    }
  }
  void applyFilter(String filter) {
    selectedFilter.value = filter;
    if (filter == 'All') {
      filteredList.value = fieldsList;
    } else {
      filteredList.value = fieldsList.where((field) => field['venueType'] == filter).toList();
    }
  }
}
