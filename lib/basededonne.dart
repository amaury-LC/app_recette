import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class Databasefavorie {


  static final _databaseName = "Favorie.db";
  static final _databaseVersion = 1;

  static final table = 'my_table_favorie';
  
  static final columnId = '_id';
  static final columnName = 'clee';
  static final columnAge = 'age';

  // make this a singleton class
  Databasefavorie._privateConstructor();
  static final Databasefavorie instance = Databasefavorie._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY,$columnName TEXT NULL)');
  }

    // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(clee) async {
    Database db = await instance.database;
    return await db.insert(table, {'clee' : clee});
  }

   // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> delete(String clee) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'clee = ?', whereArgs: [clee]);
  }


}



