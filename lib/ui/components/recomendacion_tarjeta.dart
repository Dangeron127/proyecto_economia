import 'package:flutter/material.dart';

class RecomendacionTarjeta extends StatelessWidget {
  final double montoRecomendado;

  const RecomendacionTarjeta({
    super.key,
    required this.montoRecomendado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.amber.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Recomendación diaria", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Text(
              "\$${montoRecomendado.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}