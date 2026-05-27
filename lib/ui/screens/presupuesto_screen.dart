import 'package:flutter/material.dart';
import '../interactions/presupuesto_view_model.dart'; // <--- Importamos su controlador correspondiente

class PresupuestoScreen extends StatefulWidget {
  const PresupuestoScreen({super.key});

  @override
  State<PresupuestoScreen> createState() => _PresupuestoScreenState();
}

class _PresupuestoScreenState extends State<PresupuestoScreen> {
  // Instanciamos el controlador de interacciones exclusivo de esta pantalla
  final PresupuestoViewModel _viewModel = PresupuestoViewModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Esto fuerza a la pantalla a redibujarse cada vez que vuelves a esta pestaña
    setState(() {});
  }
  
  @override
  void dispose() {
    _viewModel.dispose(); // Le delegamos la limpieza de memoria al controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tu Presupuesto",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            _viewModel.isConfigurado 
                ? "Resumen de tu dinero actual." 
                : "Dinos con cuánto cuentas para empezar a calcular tu ración diaria.",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 30),

          // Renderizamos la sección correspondiente leyendo el estado del controlador
          _viewModel.isConfigurado ? _buildPanelControl() : _buildFormularioInicial(),
        ],
      ),
    );
  }

  // VISTA A: FORMULARIO INICIAL (Limpio)

  Widget _buildFormularioInicial() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("1. ¿Cuánto dinero tienes disponible?", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: _viewModel.montoController, // Enlazado al controlador
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.attach_money, color: Colors.green),
              hintText: "Ej. 2500",
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 25),

          const Text("2. ¿Para cuántos días es este dinero?", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: _viewModel.diasController, // Enlazado al controlador
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
              hintText: "Ej. 15 (Quincena)",
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Ejecuta la transición pasando un setState para refrescar esta pantalla
                _viewModel.iniciarPlan(() => setState(() {}));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text("Iniciar Plan de Supervivencia", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }


  // VISTA B: PANEL DE CONTROL (Limpio)

  Widget _buildPanelControl() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            children: [
              const Text("Dinero Total Disponible", style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
              const SizedBox(height: 5),
              Text(
                "\$${_viewModel.saldoActual.toStringAsFixed(2)}", 
                style: TextStyle(color: Colors.blue.shade900, fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Text(
                "Presupuesto original: \$${_viewModel.presupuestoInicial.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Text("Debe rendir por ${_viewModel.diasGuardados} días", style: TextStyle(color: Colors.blue.shade700)),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 60,
          child: OutlinedButton.icon(
            onPressed: () {
              // Interacción temporal de aviso al usuario
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abriendo registro de ingreso extra...')),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green.shade700,
              side: BorderSide(color: Colors.green.shade400, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.add_circle, size: 24),
            label: const Text("Añadir Ingreso Extra", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 15),

        // Botón estructural para regresar al estado inicial
        TextButton(
          onPressed: () {
            _viewModel.reiniciarPresupuesto(() => setState(() {}));
          },
          child: const Text("Reiniciar Presupuesto (Borrar todo)", style: TextStyle(color: Colors.red)),
        )
      ],
    );
  }
}