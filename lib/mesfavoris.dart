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
import 'main.dart';

class Mesfavoris extends StatelessWidget {
  Mesfavoris(this.favoris);

  var favoris;

  var test = [
    {'titre': "test"},
    {'titre': 'test1'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes favoris"),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        children: mesfavoris
            .map<Widget>((x) => Card(
                    child: Column(children: <Widget>[
                  ListTile(
                    title: Text(x['name']),
                    subtitle: Text(x['soustitre']),
                    leading: x['photo'] != null
                        ? Image(
                            image: NetworkImage(x['photo']),
                            height: 200,
                          )
                        : Text(""),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Recettepresentation(x['record'])));
                    },
                  )
                ])))
            .toList(),
      ),
    );
  }
}

// Card(

//       child: Column(
//         children: <Widget>[ListTile(

//           title: Text(record.name),
//       subtitle: Text(record.soustitre) ,
//       trailing: IconButton(
//         icon: Icon(
//           favorite.contains(record.reference.documentID) ? Icons.favorite : Icons.favorite_border,
//           color:  favorite.contains(record.reference.documentID) ? Colors.red : null,
//         ),
//         onPressed: () {
//           changement(record.reference.documentID,record.name);
//         },
//       ),
//       onTap: () {
//          Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Recettepresentation(record)));
//       },

//       leading:  record.photo!= null ? Image(image: NetworkImage(record.photo)) : Text(""),

//         )],
//       )

//     );

// mesfavoris.map<Widget>((x)=>  Text(x['name'])).toList(),
