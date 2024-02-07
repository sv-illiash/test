import 'package:sqflite/sqlite_api.dart';
import 'package:test_app/data/datasources/local/database/database.dart';
import 'package:test_app/data/models/local/movie_model_local.dart';

class DBOperation {
  final DatabaseHelper db;
  static const String tableMovies = 'movies';

  late Database _dbInstance;

  DBOperation(this.db) {
    _initializeDb();
  }

  Future<void> _initializeDb() async => _dbInstance = await db.initializeDb();

  Future<void> insertMovies(List<CashedModel> movieItems) async {
    final batch = _dbInstance.batch();

    for (final movieItem in movieItems) {
      batch.insert(
        tableMovies,
        movieItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  Future<List<CashedModel>> selectMoviesByTitle(String title) async {
    final List<Map<String, dynamic>> maps = await _dbInstance.query(
      tableMovies,
      where: 'title LIKE ?',
      whereArgs: ['%$title%'],
    );
    return List.generate(maps.length, (i) => CashedModel.fromMap(maps[i]));
  }
}
