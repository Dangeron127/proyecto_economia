import 'package:flutter/material.dart';
import '../../services/finance_service.dart';

class PresupuestoViewModel {
  final FinanceService _financeService = FinanceService();

  bool get isConfigurado => _financeService.isConfigurado;

  // --- CAMBIO: Ahora obtenemos el saldo real disponible (inicial + ingresos - gastos) ---
  double get saldoActual => _financeService.saldoDisponible;
  
  // Mantenemos el inicial solo si queremos mostrarlo como "Presupuesto original"
  double get presupuestoInicial => _financeService.presupuestoInicial;
  
  int get diasGuardados => _financeService.diasTotales;

  final TextEditingController montoController = TextEditingController();
  final TextEditingController diasController = TextEditingController();

  void iniciarPlan(VoidCallback onUpdate) {
    if (montoController.text.isNotEmpty && diasController.text.isNotEmpty) {
      double monto = double.tryParse(montoController.text) ?? 0.0;
      int dias = int.tryParse(diasController.text) ?? 1;

      _financeService.registrarPresupuesto(monto, dias);
      onUpdate(); 
    }
  }

  void reiniciarPresupuesto(VoidCallback onUpdate) {
    montoController.clear();
    diasController.clear();
    _financeService.resetearTodo(); // Resetea el servicio central
    onUpdate();
  }

  void dispose() {
    montoController.dispose();
    diasController.dispose();
  }
}