import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text("Checkout", style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey[200]!))),
        child: SafeArea(
          child: Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.isProcessing.value ? null : () => controller.processPayment(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009966),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: controller.isProcessing.value
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text("Proceed to Payment", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          )),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          // Ambil data yang dibawa
          var data = controller.checkoutData;
          var fieldData = data['fieldData'] ?? {};
          DateTime? dateObj = data['selectedDate'];
          
          String dateString = dateObj != null ? DateFormat('E, dd MMM yyyy').format(dateObj) : '';
          int price = data['price'] ?? 0;
          String formattedPrice = "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BOOKING SUMMARY CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4), // Warna hijau sangat muda (background)
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFBFEADB)), // Warna border hijau
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Booking Summary", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
                    const SizedBox(height: 16),
                    _buildSummaryRow("Field", fieldData['name'] ?? ''),
                    const SizedBox(height: 12),
                    _buildSummaryRow("Date", dateString),
                    const SizedBox(height: 12),
                    _buildSummaryRow("Time", "${data['selectedSlot'] ?? ''} (1 Hour)"),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1, color: Color(0xFFBFEADB)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Payment", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
                        Text(formattedPrice, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF009966))),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // PAYMENT METHOD SECTION
              Text("Payment Method", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1D2939))),
              const SizedBox(height: 16),
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    _buildPaymentTile("BCA", "BCA Virtual Account", "BCA", isFirst: true),
                    const Divider(height: 1),
                    _buildPaymentTile("GOPAY", "GoPay", "GO"),
                    const Divider(height: 1),
                    _buildPaymentTile("OVO", "OVO", "OVO", isLast: true),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Widget Helper untuk baris Summary
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
        Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF1D2939))),
      ],
    );
  }

  // Widget Helper untuk baris Metode Pembayaran
  Widget _buildPaymentTile(String id, String name, String logoText, {bool isFirst = false, bool isLast = false}) {
    return Obx(() {
      bool isSelected = controller.selectedPaymentMethod.value == id;
      
      return InkWell(
        onTap: () => controller.setPaymentMethod(id),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? 16 : 0),
          bottom: Radius.circular(isLast ? 16 : 0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.transparent,
          child: Row(
            children: [
              // Fake Logo Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: id == "BCA" ? Colors.blue[50] : id == "GOPAY" ? Colors.green[50] : Colors.purple[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  logoText, 
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, 
                    fontSize: 12, 
                    color: id == "BCA" ? Colors.blue[700] : id == "GOPAY" ? Colors.green[700] : Colors.purple[700]
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? const Color(0xFF009966) : Colors.grey[300]!, width: 2),
                ),
                child: isSelected
                    ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF009966))))
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}