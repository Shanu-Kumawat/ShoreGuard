import 'package:flutter/material.dart';
import 'package:shoreguard/palette.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onTap; // Accepts a function callback for button press

  const GradientButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Palette.gradient1,
            // Palette.gradient2,
            Palette.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onTap, // Calls the passed function when pressed
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          'Rescue',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}

