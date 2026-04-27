import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycourt/widgets/button_field.dart';
import 'package:mycourt/widgets/input_field.dart';
import 'package:mycourt/widgets/pill_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Text(
                      "Create Account",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Text(
                      "Join MyCourt to book your sports fields easily",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputField(
                            placeholder: "Full Name",
                            controller: controller.fullNameController,
                            keyboardType: TextInputType.text,
                            icon: Icons.person_outline_rounded,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          InputField(
                            placeholder: "Email Address",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.email_outlined,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          InputField(
                            placeholder: "Password",
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                          ),
                          Text("Must be at least 8 characters", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          InputField(
                            placeholder: "Confirm Password",
                            controller: controller.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                          ),
              
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          ButtonField(
                            text: "Register",
                            onPressed: () {
                              controller.checkInput();
                            },
                            color: Color(0xFF009966),
                          ),
              
                          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/login');
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF009966),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
