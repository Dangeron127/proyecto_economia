import 'package:flutter/material.dart';
import '../../services/finance_service.dart';

class MascotaPanel extends StatelessWidget {
  final FinanceService _finance = FinanceService();

  MascotaPanel({super.key});

  @override
  Widget build(BuildContext context) {
    String estado = _finance.estadoMascota;
    
    return Column(
      children: [
        // Aquí Flutter buscará el archivo. Al llamarse así, no tendrás que tocar el código.
        Image.asset(
          'lib/assets/images/Dragon_$estado.png', 
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            // Esto es un "seguro" por si aún no tienes las imágenes
            return const Icon(Icons.pets, size: 100, color: Colors.grey);
          },
        ),
        const SizedBox(height: 10),
        Text(
          _obtenerMensaje(estado),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  String _obtenerMensaje(String estado) {
    switch (estado) {
      case 'triste': return "Zona Crítica: ¡Cuidado con el gasto!";
      case 'preocupado': return "Presupuesto bajo presión.";
      default: return "¡Todo bajo control!";
    }
  }
}