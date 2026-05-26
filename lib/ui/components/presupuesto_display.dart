import 'package:flutter/material.dart';

class PresupuestoDisplay extends StatelessWidget {
  final double saldoRestante;

  const PresupuestoDisplay({
    super.key,
    required this.saldoRestante,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Presupuesto Restante", style: TextStyle(fontSize: 16)),
        Text(
          "\$${saldoRestante.toStringAsFixed(2)}", // Lo formateamos de forma limpia
          style: const TextStyle(
            fontSize: 34, 
            fontWeight: FontWeight.bold, 
            color: Colors.green
          ),
        ),
      ],
    );
  }
}