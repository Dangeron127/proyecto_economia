import 'package:flutter/material.dart';
import '../../services/finance_service.dart';

class HistorialList extends StatelessWidget {
  final FinanceService _finance = FinanceService();

  @override
  Widget build(BuildContext context) {
    final gastos = _finance.historialGastos;

    if (gastos.isEmpty) {
      return const Center(child: Text("Aún no hay gastos registrados"));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gastos.length,
      itemBuilder: (context, index) {
        final gasto = gastos[index];
        return ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: Text(gasto.nombre),
          subtitle: Text(gasto.categoria),
          trailing: Text("-\$${gasto.monto.toStringAsFixed(2)}"),
        );
      },
    );
  }
}