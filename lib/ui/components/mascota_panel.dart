import 'package:flutter/material.dart';

class MascotaPanel extends StatelessWidget {
  const MascotaPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Icon(Icons.pets, size: 80, color: Colors.deepPurple),
      ),
    );
  }
}