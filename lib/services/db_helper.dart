import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/gasto.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = p.join(directory.path, 'proyecto_economia.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gastos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        monto REAL NOT NULL,
        categoria TEXT NOT NULL,
        fecha INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE settings(
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> initDb() async {
    await database;
  }

  Future<int> insertGasto(Gasto gasto) async {
    final db = await database;
    return await db.insert('gastos', gasto.toMap());
  }

  Future<List<Gasto>> getGastos() async {
    final db = await database;
    final rows = await db.query('gastos', orderBy: 'fecha DESC');
    return rows.map((row) => Gasto.fromMap(row)).toList();
  }

  Future<void> upsertSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getSetting(String key) async {
    final db = await database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return result.first['value'] as String?;
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('gastos');
    await db.delete('settings');
  }
}
