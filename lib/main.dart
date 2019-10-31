import 'package:flutter/material.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

import 'basededonne.dart';

void main() async {
  final dbHelper = Databasefavorie.instance;
  Future<List> query() async {
    var tab = [];
    final allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) => tab.add(row['clee']));

    return tab;
  }

  Future<List> favorite1;
  favorite1 = query().then((value) {
    return value;
  });

  var favorite = await favorite1;

  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Home(favorite),
  ));
}

var tab1 = [
  recette("Croque-monsieur", "1"," ", "assets/croc.jpg"),
  recette("Tacos mexicains", "2"," ","assets/tacos.jpg"),
  recette("Gaspacho au Thermomix", "3"," ","assets/gaspacho.jpg"),
  recette("Tarte au thon", "4"," ","assets/tarte.jpg"),
  recette("Samoussa rapide au boeuf", "5"," " , "assets/samoussa.jpg"),
  // recette("test4", "6", null),
];

class recette {
  recette(this.titre, this.key,this.soustitre ,this.photo);

  var titre;

  var soustitre;

  var photo;

  var key;
}

class Home extends StatelessWidget {
  Home(this.favorite);

  var favorite;

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
              (x) => lignehomewidget(x, favorite),
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
                  tab1.add(recette(myController.text, "9",' ',' '));
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
  lignehomewidget(this.x, this.favorite);

  var x;

  var favorite;

  @override
  Lignehome createState() => Lignehome(x, favorite);
}

class Lignehome extends State {
  Lignehome(this.x, this.favorite);

  var x;

  var favorite;

  

  void changement() {
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

      if (!favorite.contains(x.key)) {
        favorite.add(x.key);
        _insert(x.key);
        print('insert');
      } else {
        favorite.remove(x.key);
        _delete(x.key);
        print('delete');
      }
    });
  }

  @override
  Widget build(BuildContext context){


    return Card( 

      child: Column(
        children: <Widget>[ListTile(

          title: Text(x.titre),
      subtitle: Text(x.titre) ,
      trailing: IconButton(
        icon: Icon(
          favorite.contains(x.key) ? Icons.favorite : Icons.favorite_border,
          color: favorite.contains(x.key) ? Colors.red : null,
        ),
        onPressed: () {
          changement();
        },
      ),
      onTap: () {
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Recettepresentation(x)));
      },
      
      leading:  x.photo != null ? Image(image: AssetImage(x.photo),height: 100) : Text(""),
          
        
    

        )],
      )

    );


  }
}

// Container (
//        child: x.photo != null ? Image(image: AssetImage(x.photo),height: 100,) : Text(""),
        
//       ),

class Recettepresentation extends StatefulWidget {

  Recettepresentation(this.recette);

  var recette;

  @override
  Recettepresentationstate createState() => Recettepresentationstate(recette);

}

class Recettepresentationstate extends State {

  Recettepresentationstate(this.recette);

  var recette;

 @override
  Widget build(BuildContext context){

     return Scaffold(
      appBar: AppBar(
        title: Text(recette.titre),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body:Column(

        
        
        children: <Widget>[Container(
          
          child: recette.photo != null ? Image(image: AssetImage(recette.photo),width: 800,) : Text(""),
          
          ),Container( padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8.0), child : Text('Ingrédients' , style: TextStyle(fontSize: 24),)),

          
          
          
          ],)

      
    );

    



  }

}