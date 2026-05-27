import 'package:flutter/material.dart';
import '../components/mascota_panel.dart';
import '../components/presupuesto_display.dart';
import '../components/recomendacion_tarjeta.dart';
import '../interactions/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel interaction = HomeViewModel();

    // ListenableBuilder escucha los cambios y repinta solo esta sección
    return ListenableBuilder(
      listenable: interaction.manager, 
      builder: (context, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const MascotaPanel(),
              const SizedBox(height: 20),
              
              // Se inyectan los datos dinámicos
              PresupuestoDisplay(saldoRestante: interaction.saldoRestante),
              const SizedBox(height: 20),
              
              RecomendacionTarjeta(montoRecomendado: interaction.recomendacionDiaria),
              
              const SizedBox(height: 300),
              const Text("Fin del contenido inicial.", style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }
    );
  }
}