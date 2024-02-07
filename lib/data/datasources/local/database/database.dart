import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/data/datasources/local/database/database_operations.dart';

class DatabaseHelper {
  static const int _dbVersion = 1;
  static const String databaseName = "database.db";

  static Database? db;
  static DatabaseHelper? _instance;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance ??= DatabaseHelper._();

  Future<Database> initializeDb() async => db = await _openDatabase();

  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db ??
        await openDatabase(path, version: _dbVersion, onCreate: (Database db, int version) async {
          await createTables(db);
        });
  }

  static Future<void> createTables(Database database) async {
    await database.execute('''
      CREATE TABLE ${DBOperation.tableMovies}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        imageUrl TEXT
      )
    ''');
  }
}
