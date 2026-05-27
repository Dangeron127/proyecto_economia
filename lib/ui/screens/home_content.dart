import 'package:flutter/material.dart';
import '../components/mascota_panel.dart'; // ¡Descomentado!
import '../interactions/home_view_model.dart';
import '../../services/finance_service.dart'; // Importamos el servicio

class HomeContent extends StatefulWidget {
  final VoidCallback onBotonPanicoPresionado;

  const HomeContent({
    super.key, 
    required this.onBotonPanicoPresionado, // Recibimos la orden desde HomeScreen
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Instanciamos el servicio para poder guardar los ingresos
  final FinanceService _financeService = FinanceService();

  // 📍 NUEVO: Método del Pop-up para registrar el ingreso
  void _mostrarFormularioIngreso(BuildContext context) {
    final TextEditingController conceptController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("✨ Nuevo Ingreso Extra", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: conceptController,
                decoration: const InputDecoration(
                  labelText: "Motivo (ej. Presupuesto extra, Beca, Venta)",
                  prefixIcon: Icon(Icons.text_snippet),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Monto (\$)",
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                double monto = double.tryParse(amountController.text) ?? 0.0;
                if (conceptController.text.isNotEmpty && monto > 0) {
                  // 1. Guardamos el dinero en la memoria central
                  _financeService.registrarIngreso(conceptController.text, monto);
                  
                  // 2. Cerramos el modal
                  Navigator.pop(context);
                  
                  // 3. ¡Forzamos el rediseño para que el dragón se ponga feliz!
                  setState(() {}); 
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("¡Ingreso guardado! Tu dragón agradece el oro 🐉💰"), 
                      backgroundColor: Colors.green
                    ),
                  );
                }
              },
              child: const Text("Guardar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Instanciamos el controlador visual
    final HomeViewModel interaction = HomeViewModel();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ZONA DEL PERSONAJE (Ubicado e integrado)
          const SizedBox(height: 10),
          Center(
            child: MascotaPanel(), // Llamamos a tu dragón dinámico
          ),
          const SizedBox(height: 15),
          
          // Botón rápido para curar al dragón añadiendo dinero
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              label: const Text("Añadir Ingreso Extra", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.1),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _mostrarFormularioIngreso(context),
            ),
          ),
          
          const SizedBox(height: 25),

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
                  "Límite recomendado para gastar HOY:",
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
              onPressed: widget.onBotonPanicoPresionado, // Accedemos mediante widget. debido al State
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