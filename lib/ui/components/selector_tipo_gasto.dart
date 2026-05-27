import 'package:flutter/material.dart';

class SelectorTipoGasto extends StatelessWidget {
  final String tipoSeleccionado;
  final ValueChanged<String> onTipoCambiado;

  const SelectorTipoGasto({
    super.key,
    required this.tipoSeleccionado,
    required this.onTipoCambiado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildTab(
            label: '✨ Mis Gustitos', // Lo que lee el usuario
            isActive: tipoSeleccionado == 'Espontáneo', // La variable técnica
            activeColor: Colors.pink,
            onTap: () => onTipoCambiado('Espontáneo'), // Lo que mandamos al controlador
          ),
          _buildTab(
            label: '🛡️ Para Sobrevivir',
            isActive: tipoSeleccionado == 'Fijo',
            activeColor: Colors.green,
            onTap: () => onTipoCambiado('Fijo'),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isActive,
    required MaterialColor activeColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? activeColor.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor.shade700 : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}