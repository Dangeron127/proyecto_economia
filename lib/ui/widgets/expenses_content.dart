import 'package:flutter/material.dart';

class ExpensesContent extends StatefulWidget {
  const ExpensesContent({super.key});

  @override
  State<ExpensesContent> createState() => _ExpensesContentState();
}

class _ExpensesContentState extends State<ExpensesContent> {
  final TextEditingController _conceptController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // 'Espontáneo' representa los gustos/salidas. 'Fijo' representa la supervivencia de vivir solo.
  String _selectedType = 'Espontáneo'; 
  String _selectedCategory = ''; 
  String _selectedTransport = 'Camión';

  // =========================================================
  // CATEGORÍAS PERSONALIZADAS PARA ALGUIEN QUE VIVE SOLO
  // =========================================================
  
  // Categorías de "Estilo de vida, antojos y salidas"
  final List<Map<String, dynamic>> _spontaneousCategories = [
    {'name': 'Snacks/Antojos', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'hint': 'Ej. Esquite, frappé, papitas...'},
    {'name': 'Salidas/Fiesta', 'icon': Icons.celebration, 'color': Colors.pink, 'hint': 'Ej. Cover, alcohol, cena con amigos...'},
    {'name': 'Compras/Plaza', 'icon': Icons.shopping_bag, 'color': Colors.blue, 'hint': 'Ej. Ropa, calzado, accesorios...'},
    {'name': 'Plataformas/Juegos', 'icon': Icons.sports_esports, 'color': Colors.indigo, 'hint': 'Ej. Skin de juego, streaming...'},
  ];

  // Categorías de "Supervivencia, constancia y necesidades reales"
  final List<Map<String, dynamic>> _fixedCategories = [
    {'name': 'Despensa', 'icon': Icons.shopping_cart, 'color': Colors.green, 'hint': 'Ej. Súper mensual, recaudería, carne...'},
    {'name': 'Servicios Hogar', 'icon': Icons.bolt, 'color': Colors.amber, 'hint': 'Ej. Luz, agua, gas, internet, renta...'},
    {'name': 'Transporte Diario', 'icon': Icons.directions_bus, 'color': Colors.teal, 'hint': 'Usa el asistente de tarifas abajo...'},
    {'name': 'Salud/Higiene', 'icon': Icons.medical_services, 'color': Colors.red, 'hint': 'Ej. Medicinas, pasta dental, jabón...'},
  ];

  // Tarifas de transporte local para traslados cotidianos
  final List<Map<String, dynamic>> _transportOptions = [
    {'type': 'Camión', 'icon': Icons.directions_bus, 'fare': '\$11.00'},
    {'type': 'Taxi Local', 'icon': Icons.local_taxi, 'fare': '\$45.00'},
    {'type': 'Plataforma (Uber/Didi)', 'icon': Icons.time_to_leave, 'fare': 'Variable'},
  ];

  @override
  void initState() {
    super.initState();
    // Inicializamos la categoría por defecto según el tipo seleccionado
    _selectedCategory = _spontaneousCategories[0]['name'];
  }

  /// Cambia el tipo de gasto y resetea la categoría activa para evitar inconsistencias
  void _handleTypeChange(String type) {
    setState(() {
      _selectedType = type;
      _selectedCategory = type == 'Espontáneo' 
          ? _spontaneousCategories[0]['name'] 
          : _fixedCategories[0]['name'];
      _conceptController.clear();
      _amountController.clear();
    });
  }

  @override
  void dispose() {
    _conceptController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determinamos qué lista usar y qué colores visuales mostrar en la interfaz
    final currentCategories = _selectedType == 'Espontáneo' ? _spontaneousCategories : _fixedCategories;
    final activeColor = _selectedType == 'Espontáneo' ? Colors.pink.shade400 : Colors.green.shade600;

    // Buscamos el "hint" o sugerencia de la categoría seleccionada actualmente
    final currentHint = currentCategories.firstWhere(
      (element) => element['name'] == _selectedCategory,
      orElse: () => {'hint': 'Introduce el concepto'},
    )['hint'];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título dinámico según el enfoque del gasto
          Text(
            _selectedType == 'Espontáneo' ? "Control de Antojos" : "Gastos de Obligación",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            _selectedType == 'Espontáneo' 
                ? "Dinero destinado a diversión, salidas y cosas no vitales." 
                : "Gastos fijos necesarios para mantener tu hogar y transporte diario.",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // =========================================================
          // 1. SWITCH SELECTOR PRINCIPAL (Interfaz Dinámica)
          // =========================================================
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _handleTypeChange('Espontáneo'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedType == 'Espontáneo' ? Colors.pink.shade50 : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '💸 Espontáneos', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedType == 'Espontáneo' ? Colors.pink.shade700 : Colors.grey
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _handleTypeChange('Fijo'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedType == 'Fijo' ? Colors.green.shade50 : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '🏡 Fijos / Necesidades', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedType == 'Fijo' ? Colors.green.shade700 : Colors.grey
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // =========================================================
          // 2. DINÁMICA DE CATEGORÍAS (Cambia según la pestaña anterior)
          // =========================================================
          Text(
            _selectedType == 'Espontáneo' ? "Selecciona tu gusto:" : "Selecciona la obligación:", 
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 95,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentCategories.length,
              itemBuilder: (context, index) {
                final cat = currentCategories[index];
                final isSelected = _selectedCategory == cat['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['name']),
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
                      boxShadow: isSelected ? [] : [
                        BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                      ],
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

          // =========================================================
          // 3. FORMULARIO DE CAPTURA INTELIGENTE
          // =========================================================
          TextField(
            controller: _conceptController,
            decoration: InputDecoration(
              labelText: 'Concepto',
              hintText: currentHint, // Muestra dinámicamente ejemplos según la categoría seleccionada
              prefixIcon: const Icon(Icons.edit_note),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: activeColor, width: 2),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Monto a Registrar',
              prefixIcon: const Icon(Icons.calculate_outlined),
              prefixText: '\$ ',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: activeColor, width: 2),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 25),

          // =========================================================
          // 4. ASISTENTE DE TRANSPORTE DIARIO (Solo en Fijos -> Transporte)
          // =========================================================
          if (_selectedType == 'Fijo' && _selectedCategory == 'Transporte Diario') ...[
            const Text("Calculadora rápida de transporte", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: _transportOptions.map((option) {
                final isSelectedTransport = _selectedTransport == option['type'];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: isSelectedTransport ? Colors.teal : Colors.grey.shade200, width: 1.5),
                  ),
                  color: isSelectedTransport ? Colors.teal.shade50 : Colors.grey.shade50,
                  child: ListTile(
                    leading: Icon(option['icon'], color: Colors.teal),
                    title: Text(option['type'], style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('Precio regular: ${option['fare']}'),
                    trailing: isSelectedTransport ? const Icon(Icons.check_circle, color: Colors.teal) : null,
                    onTap: () {
                      setState(() {
                        _selectedTransport = option['type'];
                        _conceptController.text = 'Pasaje de ${_optionDescription(option['type'])}';
                        if (option['fare'] != 'Variable') {
                          _amountController.text = option['fare'].replaceAll('\$', '');
                        } else {
                          _amountController.clear();
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),
          ],

          // =========================================================
          // 5. BOTÓN ACCIÓN DE GUARDADO
          // =========================================================
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                if (_conceptController.text.isEmpty || _amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor rellena los campos'), backgroundColor: Colors.orange),
                  );
                  return;
                }
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Guardado en $_selectedCategory: ${_conceptController.text} (-\$${_amountController.text})'),
                    backgroundColor: activeColor,
                  ),
                );
                
                _conceptController.clear();
                _amountController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: activeColor,
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

  /// Devuelve un texto descriptivo rápido para el autocompletado de transporte
  String _optionDescription(String type) {
    if (type == 'Camión') return 'Ruta / Colectivo';
    if (type == 'Taxi Local') return 'Taxi';
    return 'App de transporte';
  }
}