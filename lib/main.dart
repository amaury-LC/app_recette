

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

// import 'basededonne.dart';


void main() async{
  Future<String> getDatabasesPath() => databaseFactory.getDatabasesPath();
  final Future<Database> database = openDatabase(
  // Set the path to the database. 
  join(await getDatabasesPath(), 'favorie.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      "CREATE TABLE favorie(id INTEGER PRIMARY KEY, clee : TEXT",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
  
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Home(database),
  ));
}

var tab1 = [
  recette("test1","1"),
  recette("test2","2"),
  recette("test3","3"),
  recette("test4","4"),
  recette("test4","5"),
  recette("test4","6"),


];

var favorite = [];











class recette {

  recette(this.titre,this.key);


  var titre;
  var key;
}



class Home extends StatelessWidget {

Home(this.database);

  
var database ;


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
              (x) => lignehomewidget(x,database),
            )
            .toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Enterrecit(database)),
          );
        },
        child: const Icon(Icons.add,  ),
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
              onTap: () {
                
              },
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

  Enterrecit(this.database);
  final myController = TextEditingController();

  var database;

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
              MaterialPageRoute(builder: (context) => Home(database)),
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
                  
                  tab1.add(recette(myController.text,"9"));
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

class lignehomewidget extends StatefulWidget{

  lignehomewidget(this.x,this.database);

  var x;

  var database;



  @override
  Lignehome createState() => Lignehome(x,database);
  
}

class Lignehome extends State {

  Lignehome(this.x,this.database);

  

  var x ;

  var database;







  void changement (){

    setState(() {

      if(!favorite.contains(x.key)){

        favorite.add(x.key);
      }
      else{
        favorite.remove(x.key);
      }





      
      

    });
  }

   @override
  Widget build(BuildContext context) {

   

    
    
    return  ListTile(
                title: Text(x.titre),
            
    trailing: IconButton(

      icon:  Icon(
              
               favorite.contains(x.key) ? Icons.favorite : Icons.favorite_border,
             color: favorite.contains(x.key)   ? Colors.red : null,
              ) ,
              onPressed: (){

                
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


