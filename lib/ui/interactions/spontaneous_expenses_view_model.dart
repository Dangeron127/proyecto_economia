import 'package:flutter/material.dart';

class SpontaneousExpensesViewModel {
  final conceptController = TextEditingController();
  final amountController = TextEditingController();

  // Categorías fijas de estilo de vida y antojos
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Snacks/Antojos', 'icon': Icons.bakery_dining, 'color': Colors.orange, 'hint': 'Ej. Esquite, frappé, papitas...'},
    {'name': 'Salidas/Fiesta', 'icon': Icons.celebration, 'color': Colors.pink, 'hint': 'Ej. Cover, alcohol, cena con amigos...'},
    {'name': 'Compras/Plaza', 'icon': Icons.shopping_bag, 'color': Colors.blue, 'hint': 'Ej. Ropa, calzado, accesorios...'},
    {'name': 'Plataformas/Juegos', 'icon': Icons.sports_esports, 'color': Colors.indigo, 'hint': 'Ej. Skin de juego, streaming...'},
  ];

  late String selectedCategory;
  final Color activeColor = Colors.pink.shade400;

  SpontaneousExpensesViewModel() {
    selectedCategory = categories[0]['name'];
  }

  String get currentHint {
    final cat = categories.firstWhere(
      (element) => element['name'] == selectedCategory,
      orElse: () => {'hint': 'Introduce el concepto'},
    );
    return cat['hint'];
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