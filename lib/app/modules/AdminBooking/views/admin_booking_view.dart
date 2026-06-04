import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/admin_booking_controller.dart';

class AdminBookingView extends GetView<AdminBookingController> {
  const AdminBookingView({super.key});

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
          "Bookings",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Obx(() => Row(
              children: ['All', 'Pending', 'Approved'].map((filter) {
                bool isSelected = controller.selectedFilter.value == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => controller.applyFilter(filter),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF009966) : Colors.white,
                        border: Border.all(color: isSelected ? const Color(0xFF009966) : Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filter,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF344054),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ),
          
          // List View Bookings
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xFF009966),
              backgroundColor: Colors.white,
              onRefresh: () => controller.fetchAllBookings(),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF009966)));
                }

                if (controller.filteredBookings.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada data booking.",
                      style: GoogleFonts.inter(color: Colors.grey[500]),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.filteredBookings.length,
                  itemBuilder: (context, index) {
                    return _buildBookingCard(controller.filteredBookings[index]);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    String docId = booking['id'] ?? '';
    // Buat pseudo ID cantik, misal: #BKG-A1B2C3
    String displayId = docId.length >= 6 ? "#BKG-${docId.substring(0, 6).toUpperCase()}" : "#BKG-UNKNOWN";
    
    String status = booking['status'] ?? 'PENDING';
    bool isPending = status == 'PENDING' || status == 'PAID';
    
    int price = booking['price'] ?? 0;
    String formattedPrice = "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    
    String userName = booking['userName'] ?? "User ${docId.length > 4 ? docId.substring(0, 4) : ''}";
    String fieldName = booking['fieldName'] ?? 'Unknown Field';
    String paymentMethod = booking['paymentMethod'] ?? 'Transfer';
    String date = booking['date'] ?? 'No Date';
    String slot = booking['slot'] ?? 'No Slot';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: ID & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID:  $displayId",
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPending ? Colors.orange.withOpacity(0.15) : (status == 'APPROVED' ? const Color(0xFF009966).withOpacity(0.15) : Colors.red.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isPending ? 'Pending' : status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isPending ? Colors.orange[800] : (status == 'APPROVED' ? const Color(0xFF009966) : Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row 2: User Details & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
                    const SizedBox(height: 2),
                    Text(fieldName, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formattedPrice, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
                  const SizedBox(height: 2),
                  Text("$paymentMethod Transfer", style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Row 3: Date/Time & View Proof
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text("$date, $slot", style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF475467))),
                ),
                GestureDetector(
                  onTap: () => controller.viewProof(booking['proofUrl']),
                  child: Text(
                    "View Proof",
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF009966)),
                  ),
                ),
              ],
            ),
          ),
          
          // Row 4: Action Buttons (Only for Pending)
          if (isPending) ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF2F4F7)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => controller.updateBookingStatus(docId, 'REJECTED'),
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: Text("Reject", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.updateBookingStatus(docId, 'APPROVED'),
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: Text("Approve", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF009966),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}