import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Espacio para el personaje (Placeholder animado)
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Icon(Icons.pets, size: 80, color: Colors.deepPurple),
            ),
          ),
          
          const SizedBox(height: 20),

          // Display de Presupuesto
          const Text("Presupuesto Restante", style: TextStyle(fontSize: 16)),
          const Text(
            "\$10,240.00",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.green),
          ),

          const SizedBox(height: 20),

          // Tarjeta de Recomendación Diaria
          Card(
            elevation: 0,
            color: Colors.amber.shade100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Recomendación diária", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Text("\$250.00", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Espaciador para demostrar el scroll
          const SizedBox(height: 300),
          const Text("Fin del contenido inicial."),
        ],
      ),
    );
  }
}