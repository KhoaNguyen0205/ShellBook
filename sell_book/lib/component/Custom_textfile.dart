import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final double radius;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.6),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: Color.fromARGB(255, 235, 107, 51), width: 1.2),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 243, 145, 33).withOpacity(0.86),
            offset: const Offset(3.0, 3.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Color.fromARGB(255, 32, 8, 8).withOpacity(0.86)),
          prefixIcon: icon == null
              ? null
              : Icon(icon, color: Color.fromARGB(255, 223, 17, 13)),
          prefixIconConstraints: const BoxConstraints(minWidth: 26.0),
        ),
      ),
    );
  }
}
