import 'package:flutter/material.dart';

class PillField extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool isFilled;
  final FontWeight fontWeight;
  final Color? borderColor;
  const PillField({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.borderColor,
    this.fontWeight = FontWeight.w500,
    this.isFilled = true,
  });

  @override
  State<PillField> createState() => _PillFieldState();
}

class _PillFieldState extends State<PillField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isFilled ? widget.color : Colors.transparent,
          border: widget.borderColor != null ? Border.all(color: widget.borderColor!) : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 14,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}