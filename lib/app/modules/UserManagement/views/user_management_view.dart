import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "User Management",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF009966),
        elevation: 2,
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: TextField(
                onChanged: (value) => controller.searchUser(value),
                decoration: InputDecoration(
                  hintText: "Search users...",
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List Users
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF009966)),
                  );
                }

                if (controller.filteredUsers.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada user ditemukan.",
                      style: GoogleFonts.inter(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    var user = controller.filteredUsers[index];
                    return _buildUserCard(user);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    String name = user['name'] ?? user['fullName'] ?? 'Unknown User';
    String email = user['email'] ?? 'No Email';
    String role = user['role'] ?? 'User';
    String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    Color badgeColor;
    Color badgeTextColor;
    if (role.toLowerCase() == 'admin') {
      badgeColor = Colors.purple.withOpacity(0.1);
      badgeTextColor = Colors.purple;
    } else if (role.toLowerCase() == 'manager') {
      badgeColor = Colors.blue.withOpacity(0.1);
      badgeTextColor = Colors.blue;
    } else {
      badgeColor = Colors.grey.withOpacity(0.1);
      badgeTextColor = Colors.grey[700]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF009966).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF009966),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D2939),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    // Memastikan huruf pertama kapital
                    role.isNotEmpty ? '${role[0].toUpperCase()}${role.substring(1).toLowerCase()}' : 'User',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: badgeTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 22),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Hapus User",
                    middleText: "Apakah Anda yakin ingin menghapus user ini?",
                    textConfirm: "Hapus",
                    textCancel: "Batal",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    onConfirm: () {
                      Get.back(); 
                      controller.deleteUser(user['id']);
                    },
                  );
                },
                icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 22),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}