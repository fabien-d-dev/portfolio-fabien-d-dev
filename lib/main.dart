import 'package:flutter/material.dart';
import './features/home/home_view.dart';

void main() {
  runApp(const Iamlookingforajob());
}

class Iamlookingforajob extends StatelessWidget {
  const Iamlookingforajob({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "I'm Looking For A Job",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const HomePage(), 
    );
  }
}
