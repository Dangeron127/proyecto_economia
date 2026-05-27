import 'package:flutter/material.dart';

class TarjetaCaducidad extends StatelessWidget {
  final String producto;
  final IconData icono;
  final Color color;
  final String tiempo;
  final String alerta;

  const TarjetaCaducidad({
    super.key,
    required this.producto,
    required this.icono,
    required this.color,
    required this.tiempo,
    required this.alerta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260, // Ancho fijo para que funcione en carrusel
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icono, color: color, size: 24),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  producto,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color, //Originalmente era color.shade800
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "⏳ Dura $tiempo",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            alerta,
            style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.3),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}