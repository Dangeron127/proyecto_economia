import 'package:flutter/material.dart';

class ExpensesViewModel {
  final conceptController = TextEditingController();
  final amountController = TextEditingController();

  String tipoSeleccionado = 'Espontáneo'; 
  late String categoriaSeleccionada; 

  // 1. Categorías de Espontáneos (Antojos/Salidas)
  final List<Map<String, dynamic>> spontaneousCategories = const [
    {'name': 'Snacks/Antojos', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'hint': 'Ej. Esquite, frappé, papitas...'},
    {'name': 'Salidas/Fiesta', 'icon': Icons.celebration, 'color': Colors.pink, 'hint': 'Ej. Cover, alcohol, cena con amigos...'},
    {'name': 'Compras/Plaza', 'icon': Icons.shopping_bag, 'color': Colors.blue, 'hint': 'Ej. Ropa, calzado, accesorios...'},
    {'name': 'Plataformas/Juegos', 'icon': Icons.sports_esports, 'color': Colors.indigo, 'hint': 'Ej. Skin de juego, streaming...'},
  ];

  // 2. Categorías de Fijos (Supervivencia/Obligaciones)
  final List<Map<String, dynamic>> fixedCategories = const [
    {'name': 'Despensa', 'icon': Icons.shopping_cart, 'color': Colors.green, 'hint': 'Ej. Súper mensual, recaudería, carne...'},
    {'name': 'Servicios Hogar', 'icon': Icons.bolt, 'color': Colors.amber, 'hint': 'Ej. Luz, agua, gas, internet, renta...'},
    {'name': 'Transporte Diario', 'icon': Icons.directions_bus, 'color': Colors.teal, 'hint': 'Ej. Camión, taxi, pasajes...'},
    {'name': 'Salud/Higiene', 'icon': Icons.medical_services, 'color': Colors.red, 'hint': 'Ej. Medicinas, pasta dental, jabón...'},
  ];

  ExpensesViewModel() {
    categoriaSeleccionada = spontaneousCategories[0]['name'];
  }

  // Getters dinámicos para la UI
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