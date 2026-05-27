import '../logic/finance_manager.dart';

class HomeViewModel {
  // Traemos la instancia única de nuestro gestor
  final FinanceManager manager = FinanceManager();

  // Leemos los datos reales en lugar de usar los simulados
  double get saldoRestante => manager.saldoRestante;
  double get recomendacionDiaria => manager.recomendacionDiaria;

  // Aquí puedes meter funciones en el futuro como:
  // void acariciarMascota() { ... }
}