import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycourt/widgets/button_field.dart';
import 'package:mycourt/widgets/input_field.dart';
import 'package:mycourt/widgets/pill_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
                    Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD0FAE5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/images/Flag.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Text(
                      "Welcome Back",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Text(
                      "Sign in to book your favorite court",
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
                            placeholder: "Email Address",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.email,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          InputField(
                            placeholder: "Password",
                            controller: controller.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            icon: Icons.lock,
                            isPassword: true,
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
              
                          Row(
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: controller.rememberMe.value,
                                      onChanged: (value) {
                                        controller.toggleRememberMe();
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    "Remember me",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF009966),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          ButtonField(
                            text: "Login Now",
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
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/register');
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF009966),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 16)),
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
