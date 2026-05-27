import 'package:flutter/material.dart';
import '../components/formulario_gastos.dart';
import '../components/selector_tipo_gasto.dart';
import '../interactions/expenses_view_model.dart';
import '../components/carrusel_supervivencia.dart';
import '../../services/finance_service.dart';
import '../components/historial_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ExpensesViewModel _interaction = ExpensesViewModel();
  final FinanceService _financeService = FinanceService();

  void _guardarGasto() {
    if (_interaction.conceptController.text.isEmpty || _interaction.amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor rellena los campos'), backgroundColor: Colors.orange),
      );
      return;
    }
  double monto = double.tryParse(_interaction.amountController.text) ?? 0.0;

  _financeService.registrarGasto(
      _interaction.conceptController.text, 
      monto, 
      _interaction.categoriaSeleccionada
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Guardado: ${_interaction.conceptController.text} (-\$${monto.toStringAsFixed(2)})'),
        backgroundColor: _interaction.activeColor,
      ),
    );

    setState(() {
      _interaction.limpiarFormulario();
    });
  }

  @override
  void dispose() {
    _interaction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Validación que conecta la lógica interna con la vista
    final isEspontaneo = _interaction.tipoSeleccionado == 'Espontáneo';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Títulos Dinámicos actualizados al lenguaje común
          Text(
            isEspontaneo ? "¡Momento de un Gustito!" : "Gastos para Sobrevivir",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            isEspontaneo 
                ? "Dinero destinado a pasarla chido, salidas y cosas no vitales." 
                : "Pagos obligatorios que tienes que hacer sí o sí para estar al corriente.",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // 1. INDICADOR / SELECTOR PRINCIPAL
          SelectorTipoGasto(
            tipoSeleccionado: _interaction.tipoSeleccionado,
            onTipoCambiado: (nuevoTipo) {
              setState(() {
                _interaction.cambiarTipoGasto(nuevoTipo);
              });
            },
          ),
          const SizedBox(height: 25),

          // Subtítulo de categorías dinámico
          Text(
            isEspontaneo ? "Selecciona tu gusto:" : "Selecciona la obligación:", 
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),

          // 2. LISTA DINÁMICA DE CATEGORÍAS
          SizedBox(
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _interaction.currentCategories.length,
              itemBuilder: (context, index) {
                final cat = _interaction.currentCategories[index];
                final isSelected = _interaction.categoriaSeleccionada == cat['name'];
                return GestureDetector(
                  onTap: () => setState(() => _interaction.categoriaSeleccionada = cat['name']),
                  child: Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? cat['color'].withOpacity(0.15) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? cat['color'] : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'], color: cat['color'], size: 26),
                        const SizedBox(height: 6),
                        Text(
                          cat['name'],
                          style: TextStyle(
                            fontSize: 11, 
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? cat['color'].shade900 : Colors.black87
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),

          // 3. FORMULARIO DE CAPTURA
          FormularioGastos(
            conceptController: _interaction.conceptController,
            amountController: _interaction.amountController,
            hintTexto: _interaction.currentHint,
            activeColor: _interaction.activeColor,
          ),
          const SizedBox(height: 25),

          // 🌟 EL CARRUSEL (Reubicado antes del botón para que sea visible de inmediato)
          if (!isEspontaneo && _interaction.categoriaSeleccionada == 'La Despensa') ...[
            const CarruselSupervivencia(),
            const SizedBox(height: 25),
          ],

          // 4. BOTÓN ACCIÓN DE GUARDADO (Texto dinámico)
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _guardarGasto,
              style: ElevatedButton.styleFrom(
                backgroundColor: _interaction.activeColor,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                isEspontaneo ? "Registrar mi Gustito ✨" : "Confirmar Pago Obligatorio 🛡️", 
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Historial de movimientos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          HistorialList(), // <--- Aquí aparecerá la lista de gastos registrados
          const SizedBox(height: 40),
          
          // Margen inferior extra de seguridad
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}