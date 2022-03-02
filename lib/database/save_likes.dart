import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SaveLikes {
  static const String _databaseName = 'saveLikes';
  static const int _databaseVersion = 1;
  static const String columnId = '_id';
  static const String tableName = 'saveLikes';
  static const String likeCount = 'likeCount';

  SaveLikes._privateConstructor();
  static final SaveLikes instance = SaveLikes._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $likeCount INTEGER
          )
          ''');
  }

  Future<int> addLikeCount(int count) async {
    Map<String, dynamic> row = {SaveLikes.likeCount: count};
    Database db = await database;
    db.delete(tableName);
    return await db.insert(tableName, row);
  }

  Future<List<Map>> queryAllData() async {
    Database db = await database;
    return await db.query(tableName);
  }

  void deleteDataBase() async {
    Database db = await database;
    deleteDatabase(db.path);
  }
}
