import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

import 'basededonne.dart';

void main() async {
  Future<String> getDatabasesPath() => databaseFactory.getDatabasesPath();
  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), 'favorie.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE favorie(id INTEGER PRIMARY KEY, clee TEXT )",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<List> recup() async {
        // Get a reference to the database.
        final Database db = await database;

        // Query the table for all The Dogs.
        final List<Map<String, dynamic>> maps = await db.query('favorie');

        // Convert the List<Map<String, dynamic> into a List<Dog>.
        return List.generate(maps.length, (i) {
          return maps[i]['clee'];
        });
      }

var tableau;

  recup().then((value){
    tableau = value;
  });



  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Home(database,tableau),
  ));
}



var tab1 = [
  recette("test1", "1"),
  recette("test2", "2"),
  recette("test3", "3"),
  recette("test4", "4"),
  recette("test4", "5"),
  recette("test4", "6"),
];

var favorite = [];

class recette {
  recette(this.titre, this.key);

  var titre;
  var key;
}

class Home extends StatelessWidget {
  Home(this.database,this.tableau);

  var database;

  var tableau;

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.

    return Scaffold(
      appBar: AppBar(
        title: Text('Recette de cuisine'),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        children: tab1
            .map(
              (x) => lignehomewidget(x, database, tableau),
            )
            .toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Enterrecit(database,tableau)),
          );
        },
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: Center(
                child: Text('Menu'),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(240, 88, 93, 1),
              ),
              height: 100.0,
            ),
            ListTile(
              title: Text('Recettes'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Mes favories'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Enterrecit extends StatelessWidget {
  Enterrecit(this.database,tableau);
  final myController = TextEditingController();

  var database;

  var tableau;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enregistrer une recette de cuisine'),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home(database,tableau)),
            );
          },
        ),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: myController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  tab1.add(recette(myController.text, "9"));
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class lignehomewidget extends StatefulWidget {
  lignehomewidget(this.x, this.database,this.tableau);

  var x;

  var tableau;

  var database;

  @override
  Lignehome createState() => Lignehome(x, database,tableau);
}

class Lignehome extends State {
  Lignehome(this.x, this.database,this.tableau);

  var x;


  var database;

  var tableau;



  // Future<List> recup() async {
  //       // Get a reference to the database.
  //       final Database db = await database;

  //       // Query the table for all The Dogs.
  //       final List<Map<String, dynamic>> maps = await db.query('favorie');

  //       // Convert the List<Map<String, dynamic> into a List<Dog>.
  //       return List.generate(maps.length, (i) {
  //         return maps[i]['clee'];
  //       });
  //     }

  



  void changement() {
    setState(() {
      Future<List> recup() async {
        // Get a reference to the database.
        final Database db = await database;

        // Query the table for all The Dogs.
        final List<Map<String, dynamic>> maps = await db.query('favorie');

        // Convert the List<Map<String, dynamic> into a List<Dog>.
        return List.generate(maps.length, (i) {
          return maps[i]['clee'];
        });
      }

      Future<void> insert1(clee) async {
        // Get a reference to the database.
        final Database db = await database;

        // Insert the Dog into the correct table. You might also specify the
        // `conflictAlgorithm` to use in case the same dog is inserted twice.
        //
        // In this case, replace any previous data.
        await db.insert(
          'favorie',
          {"clee": clee},
        );
      }

      Future<void> delete(key) async {
        // Get a reference to the database.
        final db = await database;

        // Remove the Dog from the Database.
        await db.delete(
          'favorie',
          // Use a `where` clause to delete a specific dog.
          where: "clee = ?",
          // Pass the Dog's id as a whereArg to prevent SQL injection.
          whereArgs: [key],
        );
      }

      // recup().then((value){
      //   print("debut");
      //   print(value);
      //   if (!tableau.contains(x.key)) {
      //   //   print(x.key);
      //   //  insert1(x.key);

      //   //  print('insert');
      //    tableau.add(x.key);
         
      //  }else{
      //    print(x.key);
      //     delete(x.key);
      //     print('delete');
      //     tableau.remove(x.key);

          

      //   }

      //   print(tableau);

      // });

     if(!tableau.contains(x.key)){

       tableau.add(x.key);
       insert1(x.key);
     }
     else{
       tableau.remove(x.key);
       delete(x.key);
     }




      



       



    });
  }

  @override
  Widget build(BuildContext context) {

    

    
    
    return ListTile(
      title: Text(x.titre),
      trailing: IconButton(
        icon: Icon(
          tableau.contains(x.key) ? Icons.favorite : Icons.favorite_border,
          color: tableau.contains(x.key) ? Colors.red : null,
        ),
        onPressed: () {
          changement();
        },
      ),
      onTap: () {
        // Update the state of the app.
        // ...
      },
    );
  }
}


