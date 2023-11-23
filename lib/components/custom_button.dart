import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Set width to fill available space
        padding: EdgeInsets.all(16.0), // Add padding for better appearance
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
