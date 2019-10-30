
// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

 

// Future<String> getDatabasesPath() => databaseFactory.getDatabasesPath();

// Future<void> insert(key) async {

// final Future<Database> database = openDatabase(
//   // Set the path to the database. 
//   join(await getDatabasesPath(), 'favorie.db'),
//   // When the database is first created, create a table to store dogs.
//   onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       "CREATE TABLE favorie(id INTEGER PRIMARY KEY, titre TEXT, key STRING)",
//     );
//   },
//   // Set the version. This executes the onCreate function and provides a
//   // path to perform database upgrades and downgrades.
//   version: 1,
// );

// // Get a reference to the database.
//   final Database db = await database;

//   await db.insert(
//     'favorie',
//     {'key' : key },
    
//   );




// }

// Future<List> recup() async{

//   final Future<Database> database = openDatabase(
//   // Set the path to the database. 
//   join(await getDatabasesPath(), 'favorie.db'),
//   // When the database is first created, create a table to store dogs.
//   onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       "CREATE TABLE favorie(id INTEGER PRIMARY KEY, titre TEXT, key STRING)",
//     );
//   },
//   // Set the version. This executes the onCreate function and provides a
//   // path to perform database upgrades and downgrades.
//   version: 1,
// );

// // Get a reference to the database.
//   final Database db = await database;

//   final List<Map<String, dynamic>> maps = await db.query('favorie');

//   // Convert the List<Map<String, dynamic> into a List<Dog>.
//   return List.generate(maps.length, (i) {
//      return maps[i]['key'];
//   });




// }

// Future<void> delete(key) async{

//   final Future<Database> database = openDatabase(
//   // Set the path to the database. 
//   join(await getDatabasesPath(), 'favorie.db'),
//   // When the database is first created, create a table to store dogs.
//   onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       "CREATE TABLE favorie(id INTEGER PRIMARY KEY, titre TEXT, key STRING)",
//     );
//   },
//   // Set the version. This executes the onCreate function and provides a
//   // path to perform database upgrades and downgrades.
//   version: 1,
// );

// // Get a reference to the database.
//   final Database db = await database;

//   // Remove the Dog from the Database.
//   await db.delete(
//     'favorie',
//     // Use a `where` clause to delete a specific dog.
//     where: "key = ?",
//     // Pass the Dog's id as a whereArg to prevent SQL injection.
//     whereArgs: [key],
//   );




// }



