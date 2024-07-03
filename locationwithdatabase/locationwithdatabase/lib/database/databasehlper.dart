

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  static final DataBaseHelper _instance = DataBaseHelper._internal();
  factory DataBaseHelper() => _instance;
  static Database? _database;
  DataBaseHelper._internal();
  Future<Database> get database async{
    if(_database != null)
      return _database!;
    _database = await _initDatabase();

    return _database!;
  }
  Future<Database> _initDatabase()async{
    String path = join(await getDatabasesPath(),'locations.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version){
          return db.execute(
              'CREATE TABLE locations(id INTEGER PRIMARY KEY AUTOINCREMENT, latitude REAL, longitude REAL, timestamp TEXT)',
          );
      },
    );
  }
  Future<void> insertLocation(double latitude, double longitude)async{
    final db = await database;
    await db.insert(
      'locations',
      {'latitude': latitude, 'longitude': longitude},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String,dynamic>>> getLocation() async{
    final db = await database;
    return await db.query('locations');
  }
  
  
}