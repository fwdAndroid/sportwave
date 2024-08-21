import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final bool isSelected; // Added isSelected parameter
  const MenuItem({
    Key? key,
    required this.title,
    required this.press,
    this.isSelected = false, // Default isSelected to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: isSelected
                ? Colors.orange
                : Colors.white, // Use custom color when isSelected
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
