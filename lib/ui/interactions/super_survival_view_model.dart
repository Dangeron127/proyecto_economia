import 'package:flutter/material.dart';

class SuperSurvivalViewModel {
  // Lista estática de tips de supervivencia del refri
  // Contiene 6 alimentos críticos que suelen echarse a perder rápido.
  final List<Map<String, dynamic>> survivalTips = const [
    {
      'producto': 'Pollo / Carne Cruda',
      'icono': Icons.set_meal,
      'color': Colors.red,
      'tiempo': '1 a 2 días',
      'alerta': 'Bomba de tiempo 💣. El refri no hace milagros. Si no lo cocinas entre hoy y mañana, ¡tíralo al congelador ya!',
    },
    {
      'producto': 'El Aguacate',
      'icono': Icons.eco,
      'color': Colors.green,
      'tiempo': '1 a 3 días',
      'alerta': 'El traidor más caro 🥑. Maduro dura 3 días en el refri. Si ya lo abriste, déjale el hueso y tienes 24 horas antes de que se haga negro.',
    },
    {
      'producto': 'Jamón / Salchichas',
      'icono': Icons.lunch_dining,
      'color': Colors.pink,
      'tiempo': '3 a 5 días',
      'alerta': 'Una vez que rompes el empaque, empieza la cuenta regresiva. Si se siente baboso o huele raro, despídete de él 🥪.',
    },
    {
      'producto': 'Sobras (Guisos/Frijoles)',
      'icono': Icons.takeout_dining,
      'color': Colors.orange,
      'tiempo': '3 a 4 días',
      'alerta': 'Los tuppers olvidados al fondo del refri 🍲. Cómetelos pronto, a partir del quinto día tu estómago empieza a correr riesgos innecesarios.',
    },
    {
      'producto': 'Tortillas de Maíz',
      'icono': Icons.album, // Icono circular que simula una tortilla
      'color': Colors.amber,
      'tiempo': '1 semana',
      'alerta': 'Afuera con el calor se hacen piedra o les sale hongo rapidísimo 🌮. Mételas al refri en una bolsa bien cerrada para que aguanten la semana.',
    },
    {
      'producto': 'Leche Abierta',
      'icono': Icons.local_drink,
      'color': Colors.blue,
      'tiempo': '5 a 7 días',
      'alerta': 'Ignora la fecha de caducidad de la caja. Una vez que quitas la tapa, el reloj corre rápido 🥛. Huélela antes de servir.',
    },
  ];
}