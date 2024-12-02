import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:convert_coin_wallet/models/MonedaClass.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'monedas.db');

    return await openDatabase(
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
        ultimoCierre REAL,
        nombre TEXT,
        moneda TEXT,
        fechaActualizacion TEXT
      )
    ''');
  }

  Future<int> insertMoneda(Moneda moneda) async {
    Database db = await instance.database;
    return await db.insert('monedas', moneda.toJson());
  }

  Future<List<Moneda>> getMonedas() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('monedas');
    return maps.map((map) => Moneda.fromJson(map)).toList();
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete('monedas');
  }
}
