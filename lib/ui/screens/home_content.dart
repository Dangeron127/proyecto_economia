import 'package:flutter/material.dart';
import '../components/mascota_panel.dart';
import '../components/presupuesto_display.dart';
import '../components/recomendacion_tarjeta.dart';
import '../interactions/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciamos el controlador de interacciones para esta pantalla
    final HomeViewModel interaction = HomeViewModel();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // 1. Espacio para el personaje
          const MascotaPanel(),
          
          const SizedBox(height: 20),

          // 2. Display de Presupuesto (inyectando datos del controlador)
          PresupuestoDisplay(saldoRestante: interaction.saldoRestante),

          const SizedBox(height: 20),

          // 3. Tarjeta de Recomendación Diaria
          RecomendacionTarjeta(montoRecomendado: interaction.recomendacionDiaria),

          // Espaciador para demostrar el scroll
          const SizedBox(height: 300),
          const Text("Fin del contenido inicial.", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}