import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycourt/app/modules/SportFields/lib/SportFields.dart';

import '../controllers/sport_fields_controller.dart';

class SportFieldsView extends GetView<SportFieldsController> {
  const SportFieldsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            "${controller.sportType.value} Fields",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Filter Chips Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => Row(
                  children: ['All', 'Indoor', 'Outdoor', 'Nearest'].map((
                    filter,
                  ) {
                    bool isSelected = controller.selectedFilter.value == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => controller.applyFilter(filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF009966)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF009966)
                                  : Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            filter,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // List View Section
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF009966)),
                );
              }

              if (controller.filteredList.isEmpty) {
                return Center(
                  child: Text(
                    "Tidak ada lapangan ${controller.sportType.value} ditemukan.",
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.filteredList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/field-detail',
                        arguments: controller.filteredList[index],
                      );
                    },
                    child: SportFieldDetailCard(
                      data: controller.filteredList[index],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
