import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/manager_dashboard_controller.dart';

class ManagerDashboardView extends GetView<ManagerDashboardController> {
  const ManagerDashboardView({super.key});

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
          "Manager Dashboard",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        color: const Color(0xFF009966),
        backgroundColor: Colors.white,
        onRefresh: () => controller.fetchDashboardData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP STATS GRID
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pending Bookings Card (Orange)
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 160, // Fixed height untuk menyamai 2 card di kanan
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 28),
                          const Spacer(),
                          Text(
                            controller.pendingBookings.value,
                            style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Pending Bookings",
                            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Kanan (Today Bookings & Revenue)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildSmallStatCard(
                          value: controller.todayBookings.value,
                          label: "Today's Bookings",
                          icon: Icons.calendar_today_outlined,
                          iconColor: Colors.blue,
                          iconBg: Colors.blue.withOpacity(0.1),
                        ),
                        const SizedBox(height: 16),
                        _buildSmallStatCard(
                          value: controller.todayRevenueFormatted.value,
                          label: "Today's Revenue",
                          icon: Icons.attach_money,
                          iconColor: const Color(0xFF009966),
                          iconBg: const Color(0xFF009966).withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                ],
              )),

              const SizedBox(height: 32),

              // RECENT BOOKINGS HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Bookings",
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939)),
                  ),
                  Text(
                    "View All",
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF009966)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // RECENT BOOKINGS LIST
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator(color: Color(0xFF009966))));
                }

                if (controller.recentBookingsList.isEmpty) {
                  return Center(child: Text("Belum ada booking terbaru.", style: GoogleFonts.inter(color: Colors.grey)));
                }

                return Column(
                  children: controller.recentBookingsList.map((booking) {
                    return _buildBookingCard(booking);
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallStatCard({
    required String value, 
    required String label, 
    required IconData icon, 
    required Color iconColor, 
    required Color iconBg
  }) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
              const SizedBox(height: 2),
              Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey[600])),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    String status = booking['status'] ?? 'PENDING';
    int price = booking['price'] ?? 0;
    String formattedPrice = "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    
    // Format Date untuk menyamai UI "Today, 19:00 - 21:00" atau "14 Apr 2026, 19:00 - 21:00"
    String dateStr = booking['date'] ?? '';
    String displayDate = dateStr;
    if (dateStr == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      displayDate = "Today";
    } else if (dateStr.isNotEmpty) {
      try {
        DateTime dt = DateFormat('yyyy-MM-dd').parse(dateStr);
        displayDate = DateFormat('dd MMM yyyy').format(dt);
      } catch (e) {
        displayDate = dateStr;
      }
    }

    bool isPending = status == 'PENDING' || status == 'PAID';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          // Header Card (User & Status)
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Dummy Avatar
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['userName'] ?? "User ${booking['userId'].toString().substring(0, 4)}", // Fallback nama
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939)),
                    ),
                    Text(
                      booking['fieldName'] ?? 'Field Name',
                      style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isPending ? Colors.orange.withOpacity(0.15) : (status == 'APPROVED' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isPending ? 'Pending' : status,
                  style: GoogleFonts.inter(
                    fontSize: 12, 
                    fontWeight: FontWeight.w600, 
                    color: isPending ? Colors.orange[800] : (status == 'APPROVED' ? Colors.green : Colors.red)
                  ),
                ),
              ),
            ],
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: Color(0xFFF2F4F7)),
          ),
          
          // Date, Time & Price
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "$displayDate, ${booking['slot'] ?? ''}",
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
              ),
              const Spacer(),
              Text(
                formattedPrice,
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939)),
              ),
            ],
          ),

          // Action Buttons (Hanya tampil jika status masih Pending)
          if (isPending) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.updateBookingStatus(booking['id'], 'REJECTED'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Reject", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.updateBookingStatus(booking['id'], 'APPROVED'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009966),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: Text("Approve", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
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