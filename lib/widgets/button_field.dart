import 'package:flutter/material.dart';

class ButtonField extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  const ButtonField({
    super.key,
    this.text = "Button",
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  State<ButtonField> createState() => _ButtonFieldState();
}

class _ButtonFieldState extends State<ButtonField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
