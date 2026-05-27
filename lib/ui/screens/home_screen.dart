import 'package:flutter/material.dart';

import '../utils/navigation_utils.dart'; 
import 'home_content.dart';              
import 'expenses_screen.dart';           
import 'presupuesto_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lo convertimos en un "get" para poder inyectar la función de navegación
  List<Widget> get _views => [
    HomeContent(
      // Esta es la magia: le pasamos una función que cambia al tab de Gastos (índice 2)
      onBotonPanicoPresionado: () {
        setState(() {
          _selectedIndex = 2; 
        });
      },
    ),
    const PresupuestoScreen(),
    const ExpensesScreen(), 
    const Center(child: Text('Más opciones')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App Financiera', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 20, color: Colors.white)
            ),
            onPressed: () {}, 
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => NavigationUtils.handleNavigation(
          index, 
          context, 
          (newIndex) => setState(() => _selectedIndex = newIndex)
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Presupuesto'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Gastos'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Más'),
        ],
      ),
    );
  }
}