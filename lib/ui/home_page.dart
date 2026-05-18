import 'package:flutter/material.dart';
import 'widgets/home_content.dart';
import 'utils/navigation_utils.dart';
import 'widgets/expenses_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de vistas disponibles
  /*final List<Widget> _views = [
    const HomeContent(),
    const Center(child: Text('Presupuesto')),
    const Center(child: Text('Gastos Espontáneos')),
  ];
  */
  
  // Lista de vistas disponibles actualizada
  final List<Widget> _views = [
    const HomeContent(),
    const Center(child: Text('Presupuesto')),
    const ExpensesContent(), // <-- Reemplazamos el "Center" anterior por nuestra nueva pantalla
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App Financiera'),
        actions: [
          IconButton(
            icon: const CircleAvatar(child: Icon(Icons.person, size: 20)),
            onPressed: () {}, // Acción para la foto de perfil
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