import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class InputField extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData icon;
  final bool isPassword;
  final Color borderColor;
  final Color backgroundColor;

   InputField({
    Key? key,
    required this.placeholder,
    required this.controller,
    required this.keyboardType,
    required this.icon,
    this.borderColor = const Color(0xFFCCCCCC),
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.borderColor),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.isPassword ? _obscure : false,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.grey),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
          border: InputBorder.none,
          contentPadding:  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
