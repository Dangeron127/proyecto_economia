import '../../services/finance_service.dart';

class HomeViewModel {
  final FinanceService _financeService = FinanceService();

  // Lee directamente los datos procesados matemáticamente
  double get saldoRestante => _financeService.saldoDisponible;
  
  double get recomendacionDiaria => _financeService.racionDiaria;

  // Este parámetro es el que le inyectaremos a tu componente MascotaPanel
  String get emocionMascota => _financeService.estadoMascota;
}