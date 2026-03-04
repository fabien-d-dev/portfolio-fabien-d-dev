import 'package:flutter/material.dart';

class FixedTopBanner extends StatelessWidget {
  final Color backgroundColor;

  const FixedTopBanner({super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor,
            backgroundColor.withOpacity(
              0.8,
            ),
            backgroundColor.withOpacity(0),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          "I'm Looking For A Job.",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
