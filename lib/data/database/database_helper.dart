import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper.internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper.internal();

  static const String _tabelFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();

    var db = openDatabase(
      '$path/$_tabelFavorite',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $_tabelFavorite (
              id TEXT PRIMARY KEY, 
              name TEXT, 
              description TEXT, 
              city TEXT, 
              address TEXT, 
              pictureId TEXT, 
              rating REAL
            );
        ''');
      },
    );
    return db;
  }

  Future<Database?> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> addFavorite(RestaurantFavorite restaurant) async {
    final db = await database;
    await db?.insert(_tabelFavorite, restaurant.toJson());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db?.delete(_tabelFavorite, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<RestaurantFavorite>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tabelFavorite);

    return result.map((e) => RestaurantFavorite.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query(_tabelFavorite, where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }
}
