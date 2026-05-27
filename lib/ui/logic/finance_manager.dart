import 'package:flutter/material.dart';

class FinanceManager extends ChangeNotifier {
  // Patrón Singleton: Crea una única instancia compartida para toda la app
  static final FinanceManager _instance = FinanceManager._internal();
  factory FinanceManager() => _instance;
  FinanceManager._internal();

  // Aquí definimos el saldo inicial
  double _saldoRestante = 10240.00;
  double _recomendacionDiaria = 250.00;

  double get saldoRestante => _saldoRestante;
  double get recomendacionDiaria => _recomendacionDiaria;

  // Función matemática que los botones van a llamar
  void registrarGasto(double monto) {
    _saldoRestante -= monto;
    
    // Evitamos que el saldo sea negativo visualmente
    if (_saldoRestante < 0) _saldoRestante = 0;
    
    // Recalculamos la recomendación diaria (Ejemplo: dividimos lo que queda entre 30 días)
    _recomendacionDiaria = _saldoRestante / 30; 
    
    // IMPORTANTE: Esto avisa a las pantallas que los números cambiaron y deben repintarse
    notifyListeners(); 
  }
}