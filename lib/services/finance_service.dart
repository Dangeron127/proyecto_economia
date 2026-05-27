import '../../models/gasto.dart';

class FinanceService {
  static final FinanceService _instance = FinanceService._internal();
  factory FinanceService() => _instance;
  FinanceService._internal();

  // NUEVA VARIABLE DE ESTADO GLOBAL 
  bool isConfigurado = false; //Se queda guardado aquí permanentemente

  double presupuestoInicial = 0.0;
  int diasTotales = 1;
  double gastosAcumulados = 0.0;
  double ingresosExtra = 0.0;
  double umbralMinimoDiario = 0.0;
  final double pisoDignidad = 60.0;

  double get saldoDisponible => (presupuestoInicial + ingresosExtra) - gastosAcumulados;
  double get racionDiaria => saldoDisponible / diasTotales;

  // Lógica unificada para el estado de la mascota
  String get estadoMascota {
    if (!isConfigurado) return 'feliz'; // Estado por defecto antes de configurar
    if (saldoDisponible <= 0) return 'triste'; // Sin saldo -> estado crítico
    if (racionDiaria < umbralMinimoDiario) return 'triste';
    if (racionDiaria < (umbralMinimoDiario * 1.5)) return 'preocupado';
    return 'feliz';
  }

final List<Gasto> _historialGastos = [];

List<Gasto> get historialGastos => List.unmodifiable(_historialGastos);

  void registrarPresupuesto(double monto, int dias) {
    presupuestoInicial = monto;
    diasTotales = dias > 0 ? dias : 1;
    double calculoPorcentaje = (presupuestoInicial * 0.20) / diasTotales;
    umbralMinimoDiario = (calculoPorcentaje > pisoDignidad) ? calculoPorcentaje : pisoDignidad;
    gastosAcumulados = 0.0; 
    ingresosExtra = 0.0;
    isConfigurado = true; // <--- Se activa al registrar
  }

  // (El getter `estadoMascota` fue unificado arriba.)
  void resetearTodo() {
    presupuestoInicial = 0.0;
    diasTotales = 1;
    gastosAcumulados = 0.0;
    ingresosExtra = 0.0;
    isConfigurado = false; // <--- Se desactiva al reiniciar
    _historialGastos.clear(); // Limpiamos también el historial de gastos
  }

  void registrarGasto(String nombre, double monto, String categoria) {
    final nuevoGasto = Gasto(
      nombre: nombre, 
      monto: monto, 
      categoria: categoria, 
      fecha: DateTime.now()
    );
    _historialGastos.add(nuevoGasto);
    gastosAcumulados += monto; // Esto actualiza automáticamente tu saldo y ración diaria
  }

  //void registrarIngresoExtra(double monto) => ingresosExtra += monto;

  void registrarIngreso(String concepto, double monto) {
    ingresosExtra += monto;
    }
}