import '../../models/gasto.dart';
import 'db_helper.dart';

class FinanceService {
  static final FinanceService _instance = FinanceService._internal();
  factory FinanceService() => _instance;
  FinanceService._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  bool isConfigurado = false; // Se queda guardado aquí permanentemente

  double presupuestoInicial = 0.0;
  int diasTotales = 1;
  double gastosAcumulados = 0.0;
  double ingresosExtra = 0.0;
  double umbralMinimoDiario = 0.0;
  final double pisoDignidad = 60.0;

  double get saldoDisponible => (presupuestoInicial + ingresosExtra) - gastosAcumulados;
  double get racionDiaria => saldoDisponible / diasTotales;

  String get estadoMascota {
    if (!isConfigurado) return 'feliz';
    if (saldoDisponible <= 0) return 'triste';
    if (racionDiaria < umbralMinimoDiario) return 'triste';
    if (racionDiaria < (umbralMinimoDiario * 1.5)) return 'preocupado';
    return 'feliz';
  }

  final List<Gasto> _historialGastos = [];

  List<Gasto> get historialGastos => List.unmodifiable(_historialGastos);

  Future<void> init() async {
    await _dbHelper.initDb();
    await _cargarDatosDesdeDb();
  }

  Future<void> _cargarDatosDesdeDb() async {
    final gastos = await _dbHelper.getGastos();
    _historialGastos
      ..clear()
      ..addAll(gastos);
    gastosAcumulados = _historialGastos.fold(0.0, (double total, gasto) => total + gasto.monto);

    final configurado = await _dbHelper.getSetting('isConfigurado');
    if (configurado == 'true') {
      presupuestoInicial = double.tryParse(await _dbHelper.getSetting('presupuestoInicial') ?? '0') ?? 0.0;
      diasTotales = int.tryParse(await _dbHelper.getSetting('diasTotales') ?? '1') ?? 1;
      ingresosExtra = double.tryParse(await _dbHelper.getSetting('ingresosExtra') ?? '0') ?? 0.0;
      umbralMinimoDiario = double.tryParse(await _dbHelper.getSetting('umbralMinimoDiario') ?? '0') ?? 0.0;
      isConfigurado = true;
    }
  }

  Future<void> registrarPresupuesto(double monto, int dias) async {
    presupuestoInicial = monto;
    diasTotales = dias > 0 ? dias : 1;
    double calculoPorcentaje = (presupuestoInicial * 0.20) / diasTotales;
    umbralMinimoDiario = (calculoPorcentaje > pisoDignidad) ? calculoPorcentaje : pisoDignidad;
    gastosAcumulados = 0.0;
    ingresosExtra = 0.0;
    isConfigurado = true;

    await _dbHelper.upsertSetting('isConfigurado', 'true');
    await _dbHelper.upsertSetting('presupuestoInicial', presupuestoInicial.toString());
    await _dbHelper.upsertSetting('diasTotales', diasTotales.toString());
    await _dbHelper.upsertSetting('ingresosExtra', ingresosExtra.toString());
    await _dbHelper.upsertSetting('umbralMinimoDiario', umbralMinimoDiario.toString());
  }

  Future<void> resetearTodo() async {
    presupuestoInicial = 0.0;
    diasTotales = 1;
    gastosAcumulados = 0.0;
    ingresosExtra = 0.0;
    umbralMinimoDiario = 0.0;
    isConfigurado = false;
    _historialGastos.clear();
    await _dbHelper.clearAll();
  }

  Future<void> registrarGasto(String nombre, double monto, String categoria) async {
    final nuevoGasto = Gasto(
      nombre: nombre,
      monto: monto,
      categoria: categoria,
      fecha: DateTime.now(),
    );
    await _dbHelper.insertGasto(nuevoGasto);
    _historialGastos.add(nuevoGasto);
    gastosAcumulados += monto;
  }

  Future<void> registrarIngreso(String concepto, double monto) async {
    ingresosExtra += monto;
    await _dbHelper.upsertSetting('ingresosExtra', ingresosExtra.toString());
  }
}