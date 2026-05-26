import 'package:flutter/material.dart';
import '../components/formulario_gastos.dart';
import '../interactions/spontaneous_expenses_view_model.dart';

class SpontaneousExpensesScreen extends StatefulWidget {
  const SpontaneousExpensesScreen({super.key});

  @override
  State<SpontaneousExpensesScreen> createState() => _SpontaneousExpensesScreenState();
}

class _SpontaneousExpensesScreenState extends State<SpontaneousExpensesScreen> {
  final SpontaneousExpensesViewModel _interaction = SpontaneousExpensesViewModel();

  void _guardarGasto() {
    if (_interaction.conceptController.text.isEmpty || _interaction.amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor rellena los campos'), backgroundColor: Colors.orange),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Guardado en ${_interaction.selectedCategory}: ${_interaction.conceptController.text} (-\$${_interaction.amountController.text})'),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Control de Antojos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Dinero destinado a diversión, salidas y cosas no vitales.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 25),

          const Text("Selecciona tu gusto:", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Selector de categorías horizontal
          SizedBox(
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _interaction.categories.length,
              itemBuilder: (context, index) {
                final cat = _interaction.categories[index];
                final isSelected = _interaction.selectedCategory == cat['name'];
                return GestureDetector(
                  onTap: () => setState(() => _interaction.selectedCategory = cat['name']),
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

          // Formulario Modularizado
          FormularioGastos(
            conceptController: _interaction.conceptController,
            amountController: _interaction.amountController,
            hintTexto: _interaction.currentHint,
            activeColor: _interaction.activeColor,
          ),
          const SizedBox(height: 25),

          // Botón de Confirmación
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
              child: const Text(
                "Confirmar y Descontar", 
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }
}