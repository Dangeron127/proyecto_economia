import 'package:flutter/material.dart';
import '../components/mascota_panel.dart';
// Asumimos que aún tienes tus componentes originales o que los adaptaremos luego
import '../interactions/home_view_model.dart';

class HomeContent extends StatelessWidget {
  final VoidCallback onBotonPanicoPresionado;

  const HomeContent({
    super.key, 
    required this.onBotonPanicoPresionado, // Recibimos la orden desde HomeScreen
  });

  @override
  Widget build(BuildContext context) {
    // Instanciamos el controlador
    final HomeViewModel interaction = HomeViewModel();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ZONA DEL PERSONAJE
          const MascotaPanel(),
          
          const SizedBox(height: 30),

          // 2. RADAR DE SUPERVIVENCIA (El Número Mágico)
          const Text(
            "Radar de Supervivencia 🎯",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Límite seguro para gastar HOY:",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  "\$${interaction.recomendacionDiaria.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 42, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Te quedan \$${interaction.saldoRestante} para llegar a fin de mes.",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          // 3. EL BOTÓN DE PÁNICO (Gasto Hormiga Rápido)
          SizedBox(
            width: double.infinity,
            height: 65,
            child: ElevatedButton.icon(
              onPressed: onBotonPanicoPresionado, // ¡Dispara la navegación!
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Text('🚨', style: TextStyle(fontSize: 24)),
              label: const Text(
                "¡Caí en la tentación!\nRegistrar gasto rápido",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 50), // Espaciador final
        ],
      ),
    );
  }
}