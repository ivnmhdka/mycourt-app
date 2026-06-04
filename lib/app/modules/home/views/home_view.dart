import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycourt/widgets/button_field.dart';
import 'package:mycourt/widgets/feature_card.dart';
import 'package:mycourt/widgets/input_field.dart';
import 'package:mycourt/widgets/pill_field.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 374,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A9B6D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Logo.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "MyCourt",
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  PillField(
                                    text: "Login",
                                    onPressed: () {
                                      Get.toNamed('/login');
                                    },
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    borderColor: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                              SizedBox(height: 32),
                              Text(
                                "Book a Court\nin Seconds",
                                style: GoogleFonts.inter(
                                  fontSize: 30,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Find and book your favorite court with ease",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: 328,
                    height: 240,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          InputField(
                            placeholder: "Search a venue or sport",
                            controller: TextEditingController(),
                            keyboardType: TextInputType.text,
                            icon: Icons.search,
                            borderColor: Colors.transparent,
                            backgroundColor: const Color.fromARGB(
                              135,
                              238,
                              238,
                              238,
                            )!,
                          ),
                          SizedBox(height: 16),
                          InputField(
                            placeholder: "",
                            controller: TextEditingController(),
                            keyboardType: TextInputType.text,
                            icon: Icons.calendar_today,
                            borderColor: Colors.transparent,
                            backgroundColor: const Color.fromARGB(
                              135,
                              238,
                              238,
                              238,
                            )!,
                          ),
                          SizedBox(height: 16),
                          ButtonField(
                            onPressed: () {},
                            text: "Search Schedule",
                            color: Color(0xFF009966),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 160),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why MyCourt?",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FeatureCard(
                          title: "Realtime Schedule",
                          icon: Icons.check_circle_outline,
                          circleColor: Color(0xFFD1FADF),
                          iconColor: Color(0xFF027A48),
                        ),
                        SizedBox(width: 16),
                        FeatureCard(
                          title: "Payment Gateway",
                          icon: Icons.check_circle_outline,
                          circleColor: Color(0xFFD1FADF),
                          iconColor: Color(0xFF027A48),
                        ),
                        SizedBox(width: 16),
                        FeatureCard(
                          title: "Real-Time Availability",
                          icon: Icons.check_circle_outline,
                          circleColor: Color(0xFFD1FADF),
                          iconColor: Color(0xFF027A48),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36,),
                  Container(
                    width: double.infinity,
                    height: 220,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFDCFCE7),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ready to play?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Join thousands of players booking daily.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ButtonField(
                            onPressed: () {
                              Get.toNamed('/register');
                            },
                            text: "Get Started",
                            color: const Color(0xFF009966),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
