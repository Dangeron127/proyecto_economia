// lib/ui/screens/home_screen.dart
import 'package:flutter/material.dart';

// REEMPLAZO DE IMPORTS: Apuntamos a la nueva estructura de carpetas
import '../utils/navigation_utils.dart'; // Si moviste tus utils a ui/common
import 'home_content.dart';               // Asumiendo que home_content también vive en ui/screens
import 'expenses_screen.dart';           // Tu nueva pantalla ensamblada

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de vistas disponibles actualizada con la nueva pantalla estructurada
  final List<Widget> _views = [
    const HomeContent(),
    const Center(child: Text('Presupuesto')),
    const ExpensesScreen(), // <-- Nueva pantalla de gastos espontáneos
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App Financiera'),
        actions: [
          IconButton(
            icon: const CircleAvatar(child: Icon(Icons.person, size: 20)),
            onPressed: () {}, 
          ),
        ],
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => NavigationUtils.handleNavigation(
          index, 
          context, 
          (newIndex) => setState(() => _selectedIndex = newIndex)
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Presupuesto'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Gastos'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Más'),
        ],
      ),
    );
  }
}