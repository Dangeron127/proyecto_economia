import 'package:flutter/material.dart';
import '../interactions/super_survival_view_model.dart';
import 'tarjeta_caducidad.dart';

class CarruselSupervivencia extends StatelessWidget {
  const CarruselSupervivencia({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciamos los datos
    final viewModel = SuperSurvivalViewModel();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reglas de Supervivencia del Refri 🧊",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          "Para que no tires comida (ni dinero).",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 180, // Altura fija del carrusel
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: viewModel.survivalTips.length,
            itemBuilder: (context, index) {
              final tip = viewModel.survivalTips[index];
              return TarjetaCaducidad(
                producto: tip['producto'],
                icono: tip['icono'],
                color: tip['color'],
                tiempo: tip['tiempo'],
                alerta: tip['alerta'],
              );
            },
          ),
        ),
      ],
    );
  }
}