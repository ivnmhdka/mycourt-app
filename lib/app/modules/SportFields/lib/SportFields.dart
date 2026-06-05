import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SportFieldDetailCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const SportFieldDetailCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int price = data['pricePerHour'] ?? 0;
    String formattedPrice = "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    
    // Fallback jika array amenities belum ada di database
    List<dynamic> amenities = data['amenities'] ?? ['Parking', 'Toilet'];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dan Badge Rating
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  data['imageUrl'] ?? '',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        (data['rating'] ?? 0.0).toString(),
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Detail Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data['name'] ?? '',
                        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(formattedPrice, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF009966))),
                        Text("/hr", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(data['venueType'] ?? '', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 12),
                
                // Amenities Chips
                Wrap(
                  spacing: 8,
                  children: amenities.map((amenity) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                    child: Text(amenity.toString(), style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                
                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Nanti arahkan ke halaman detail/booking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009966),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text("View Schedule & Book", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}