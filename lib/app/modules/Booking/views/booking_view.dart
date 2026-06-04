import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Select Date & Time",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.goToCheckout(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009966),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                "Confirm Booking",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih Tanggal",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D2939),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF009966),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    controller.changeSelectedDate(picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat(
                          'EEEE, dd MMMM yyyy',
                        ).format(controller.selectedDate.value),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFF009966),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            Text(
              "Pilih Jam Lapangan (Per Jam)",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D2939),
              ),
            ),
            const SizedBox(height: 16),

            Obx(() {
              // Obx luar memantau status loading
              if (controller.isLoadingSlots.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(color: Color(0xFF009966)),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.2,
                ),
                itemCount: controller.timeSlots.length,
                itemBuilder: (context, index) {
                  String currentSlot = controller.timeSlots[index];

                  // PERUBAHAN DI SINI: Tambahkan Obx untuk setiap item satuan
                  return Obx(() {
                    // Logika warna dipindahkan ke dalam Obx agar dievaluasi ulang saat di-klik
                    bool isBooked = controller.bookedSlots.contains(
                      currentSlot,
                    );
                    bool isSelected =
                        controller.selectedSlot.value == currentSlot;

                    Color backgroundColor = Colors.white;
                    Color textColor = const Color(0xFF344054);
                    Border border = Border.all(color: Colors.grey[300]!);

                    if (isBooked) {
                      backgroundColor = Colors.grey[100]!;
                      textColor = Colors.grey[400]!;
                    } else if (isSelected) {
                      backgroundColor = const Color(0xFF009966);
                      textColor = Colors.white;
                      border = Border.all(color: const Color(0xFF009966));
                    }

                    return GestureDetector(
                      onTap: isBooked
                          ? null
                          : () {
                              controller.selectedSlot.value = currentSlot;
                            },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: border,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          currentSlot,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: textColor,
                            decoration: isBooked
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
