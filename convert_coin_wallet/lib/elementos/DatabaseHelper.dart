import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'monedas.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE monedas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        compra REAL,
        venta REAL,
        ultimocierre REAL,
        nombre TEXT,
        moneda TEXT,
        fechaActualizacion TEXT
      )
    ''');
  }

  Future<int> insertMoneda(Map<String, dynamic> moneda) async {
    final db = await database;
    return db.insert('monedas', moneda);
  }

  Future<List<Map<String, dynamic>>> getMonedas() async {
    final db = await database;
    return db.query('monedas');
  }

  Future<int> updateMoneda(int id, Map<String, dynamic> moneda) async {
    final db = await database;
    return db.update(
      'monedas',
      moneda,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
