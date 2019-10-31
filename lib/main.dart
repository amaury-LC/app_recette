

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';


 import 'basededonne.dart';

 




void main() async{
//   Future<String> getDatabasesPath() => databaseFactory.getDatabasesPath();
//   final Future<Database> database = openDatabase(
//   // Set the path to the database. 
//   join(await getDatabasesPath(), 'favorie.db'),
//   // When the database is first created, create a table to store dogs.
//   onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       "CREATE TABLE favorie(id INTEGER PRIMARY KEY, clee : TEXT)",
//     );
//   },
//   // Set the version. This executes the onCreate function and provides a
//   // path to perform database upgrades and downgrades.
//   version: 1,
// );

  // var favorite  = [];
 var text = "";
  void test(){

  text = "bonjour";

}


  final dbHelper = Databasefavorie.instance;
 Future<List>  query() async {
    var tab  = [];
    final allRows = await dbHelper.queryAllRows();
   
     allRows.forEach((row) => tab.add(row['clee']) );

    

    return tab;
      
  
 
  }

  

 



Future<List> favorite1 ;
favorite1 =  query().then((value) { return value; }) ;

var favorite = await favorite1;








  

  
  
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Home(favorite),
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













class recette {

  recette(this.titre,this.key);


  var titre;
  var key;
}



class Home extends StatelessWidget {

Home(this.favorite);

var  favorite;

  


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
              (x) => lignehomewidget(x,favorite),
            )
            .toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Enterrecit(favorite)),
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

  Enterrecit(this.favorite);

  var favorite;

 
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
              MaterialPageRoute(builder: (context) => Home(favorite)),
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

  lignehomewidget(this.x,this.favorite);

  var x;

  var favorite;

  





  @override
  Lignehome createState() => Lignehome(x,favorite);
  
}

class Lignehome extends State {

  Lignehome(this.x,this.favorite);

  

  var x ;

  var favorite;

  
 

 

  





  void changement (){

    setState(() {

         final dbHelper = Databasefavorie.instance;

      void _insert(clee) async {
    
     await dbHelper.insert(clee);
    
  }

  

    void _delete(clee) async {
    // Assuming that the number of rows is the id for the last row.

   await dbHelper.delete(clee);
  
  }


  // _insert();

  // _delete();








      if(!favorite.contains(x.key)){

        favorite.add(x.key);
         _insert(x.key);
         print('insert');
        

      }
      else{
        favorite.remove(x.key);
        _delete(x.key);
        print('delete');
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




// import 'package:flutter/material.dart';
// // change `flutter_database` to whatever your project name is
// import 'database_helper.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SQFlite Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {

//   // reference to our single class that manages the database
//   final dbHelper = DatabaseHelper.instance;

//   // homepage layout
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('sqflite'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               child: Text('insert', style: TextStyle(fontSize: 20),),
//               onPressed: () {_insert();},
//             ),
//             RaisedButton(
//               child: Text('query', style: TextStyle(fontSize: 20),),
//               onPressed: () {_query();},
//             ),
//             RaisedButton(
//               child: Text('update', style: TextStyle(fontSize: 20),),
//               onPressed: () {_update();},
//             ),
//             RaisedButton(
//               child: Text('delete', style: TextStyle(fontSize: 20),),
//               onPressed: () {_delete();},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   // Button onPressed methods
  
//   void _insert() async {
//     // row to insert
//     Map<String, dynamic> row = {
//       DatabaseHelper.columnName : 'Bob',
//       DatabaseHelper.columnAge  : 23
//     };
//     final id = await dbHelper.insert(row);
//     print('inserted row id: $id');
//   }

//   void _query() async {
//     final allRows = await dbHelper.queryAllRows();
//     print('query all rows:');
//     allRows.forEach((row) => print(row));
//   }

//   void _update() async {
//     // row to update
//     Map<String, dynamic> row = {
//       DatabaseHelper.columnId   : 1,
//       DatabaseHelper.columnName : 'Mary',
//       DatabaseHelper.columnAge  : 32
//     };
//     final rowsAffected = await dbHelper.update(row);
//     print('updated $rowsAffected row(s)');
//   }

//   void _delete() async {
//     // Assuming that the number of rows is the id for the last row.
//     final id = await dbHelper.queryRowCount();
//     final rowsDeleted = await dbHelper.delete(id);
//     print('deleted $rowsDeleted row(s): row $id');
//   }
// }