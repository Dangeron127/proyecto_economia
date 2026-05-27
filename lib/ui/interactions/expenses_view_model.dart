import 'package:flutter/material.dart';

class ExpensesViewModel {
  final conceptController = TextEditingController();
  final amountController = TextEditingController();

  String tipoSeleccionado = 'Espontáneo'; 
  late String categoriaSeleccionada; 

  final List<Map<String, dynamic>> spontaneousCategories = const [
    {'name': 'Snacks/Antojos', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'hint': 'Ej. Unos esquites, frappé...'},
    {'name': 'Salidas/Fiesta', 'icon': Icons.celebration, 'color': Colors.pink, 'hint': 'Ej. Entrada al antro, cena...'},
    {'name': 'Compras/Plaza', 'icon': Icons.shopping_bag, 'color': Colors.blue, 'hint': 'Ej. Ropa, unos tenis...'},
    {'name': 'Juegos/Streaming', 'icon': Icons.sports_esports, 'color': Colors.indigo, 'hint': 'Ej. Una skin, Netflix...'},
  ];

  final List<Map<String, dynamic>> fixedCategories = const [
    // 👉 ASEGURAMOS QUE SE LLAME "La Despensa" PARA EL IF MÁS ADELANTE
    {'name': 'La Despensa', 'icon': Icons.shopping_cart, 'color': Colors.green, 'hint': 'Ej. El súper del mes, fruta...'},
    {'name': 'Recibos/Servicios', 'icon': Icons.bolt, 'color': Colors.amber, 'hint': 'Ej. Luz, agua, internet...'},
    {'name': 'Transporte Diario', 'icon': Icons.directions_bus, 'color': Colors.teal, 'hint': 'Ej. Pasajes de camión...'},
    {'name': 'Salud e Higiene', 'icon': Icons.medical_services, 'color': Colors.red, 'hint': 'Ej. Medicinas, consultas...'},
  ];

  ExpensesViewModel() {
    categoriaSeleccionada = spontaneousCategories[0]['name'];
  }

  List<Map<String, dynamic>> get currentCategories =>
      tipoSeleccionado == 'Espontáneo' ? spontaneousCategories : fixedCategories;

  Color get activeColor =>
      tipoSeleccionado == 'Espontáneo' ? Colors.pink.shade400 : Colors.green.shade600;

  String get currentHint {
    final cat = currentCategories.firstWhere(
      (element) => element['name'] == categoriaSeleccionada,
      orElse: () => {'hint': 'Introduce el concepto'},
    );
    return cat['hint'];
  }

  void cambiarTipoGasto(String nuevoTipo) {
    tipoSeleccionado = nuevoTipo;
    categoriaSeleccionada = nuevoTipo == 'Espontáneo' 
        ? spontaneousCategories[0]['name'] 
        : fixedCategories[0]['name'];
    limpiarFormulario();
  }

  void limpiarFormulario() {
    conceptController.clear();
    amountController.clear();
  }

  void dispose() {
    conceptController.dispose();
    amountController.dispose();
  }
}