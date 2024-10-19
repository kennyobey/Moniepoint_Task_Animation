import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onSettingsPressed;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onSettingsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
  ),
  alignment: Alignment.center,
  child: TextField(
    controller: controller,
    decoration: const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
      prefixIcon: Icon(Icons.search, color: Colors.black),
      hintText: "Saint Petersburg",
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: Colors.black, 
        fontWeight: FontWeight.w400
      ),
    ),
  ),
),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.tune, // This represents the settings icon
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
