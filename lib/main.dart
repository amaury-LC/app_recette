import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

import 'presentation.dart';
import 'lignewidger.dart';

import 'basededonne.dart';
import 'entrer_recette.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "mesfavoris.dart";
import 'dart:convert';
import 'ml.dart';



final dbHelper = Databasefavorie.instance;


var mesfavoris ;



void queryfavoris() async {
    var tab1 = [];

    final allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) =>  tab1.add({'id' : row['clee'], 'name' : row['name'], 'photo' : row['photo'], 'soustitre' : row['soustitre'],'ingredient' : row['ingredient'],'etape' : row['etape'] }));

    

  

     mesfavoris = await tab1;



}







void main() async {

  queryfavoris();
  
  Future<List> query() async {
    var tab = [];
    final allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) =>  tab.add(row['clee']));

    print(tab);

    return tab;
  }

  Future<List> favorite1;
  favorite1 = query().then((value) {
    return value;
  });

  var favorite = await favorite1;

  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: HomeStream(favorite),
  ));
}



// var tab1 = [
//   recette("Croque-monsieur", "1", " ", "assets/croc.jpg"),
//   recette("Tacos mexicains", "2", " ", "assets/tacos.jpg"),
//   recette("Gaspacho au Thermomix", "3", " ", "assets/gaspacho.jpg"),
//   recette("Tarte au thon", "4", " ", "assets/tarte.jpg"),
//   recette("Samoussa rapide au boeuf", "5", " ", "assets/samoussa.jpg"),
//   // recette("test4", "6", null),
// ];

class recette {
  recette(this.titre, this.key, this.soustitre, this.photo);

  var titre;

  var soustitre;

  var photo;

  var key;
}

class Home extends StatelessWidget {
  Home(this.favorite,this.mesrecettes);

  var favorite;

  List<DocumentSnapshot> mesrecettes;

  

  @override
  Widget build(BuildContext context) {
    
    // Scaffold is a layout for the major Material Components.

    return Scaffold(
      appBar: AppBar(
        title: Text('FOODAPP'),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

        children: mesrecettes
            .map(
              (x) => lignehomewidget(x, favorite),
            )
            .toList(),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Enterrecit(favorite,mesrecettes)),
      //     );
      //   },
      //   child: const Icon(
      //     Icons.add,
      //   ),
      //   backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      // ),

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
              title: Text('Mes Recettes'),
              onTap: () {

                 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home(favorite,mesrecettes)),
          );


              },
            ),
             ListTile(
              title: Text('ML'),
              onTap: () {

                 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FacePage()),
          );


              },
            ),
            ListTile(
              title: Text('Mes favoris'),
              onTap: () {
                 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Mesfavoris(favorite)),
          );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeStream extends StatelessWidget {

  HomeStream(this.favorite);

  var favorite; 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('recettes').snapshots(),
      builder: (context, mesrecettes) {
        if (!mesrecettes.hasData) return LinearProgressIndicator();

        return Home(favorite, mesrecettes.data.documents);
      },
    );
  }
}

