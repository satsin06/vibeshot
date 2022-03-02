import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedUserData {
  static const String _databaseName = 'savedData';
  static const int _databaseVersion = 1;
  static const String columnId = '_id';
  static const String tableName = 'userData';
  static const String intreststable = 'intrestsTable';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String age = 'age';
  static const String gender = 'gender';
  static const String aboutMe = 'aboutMe';
  static const String interestedInGender = 'interestedInGender';
  static const String minAge = 'minAge';
  static const String maxAge = 'maxAge';
  static const String lookingFor = 'lookingFor';
  static const String interests = 'interests';
  static const String contact = 'contact';

  SavedUserData._privateConstructor();
  static final SavedUserData instance = SavedUserData._privateConstructor();

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
    await db.execute(
        '''
          CREATE TABLE $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $userId TEXT,
          $name TEXT,
          $age INTEGER,
          $gender TEXT,
          $aboutMe TEXT,
          $interestedInGender TEXT,
          $minAge INTEGER,
          $maxAge INTEGER,
          $lookingFor TEXT,
          $contact TEXT
          )
          ''');
    await db.execute(
        '''
          CREATE TABLE $intreststable (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $interests TEXT
          )
          ''');
  }

  Future<int> addUserDetails(Map<String, dynamic> row) async {
    Database db = await instance.database;
    db.delete(tableName);
    return await db.insert(tableName, row);
  }

  Future addIntrests(Map<String, dynamic> row) async {
    Database db = await instance.database;
    db.delete(intreststable);
    return await db.insert(intreststable, row);
  }

  Future<List<Map>> queryAllData() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }
}
