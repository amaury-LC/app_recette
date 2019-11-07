import 'package:flutter/material.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

import 'presentation.dart';
import 'lignewidger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'basededonne.dart';
import 'main.dart';


class Enterrecit extends StatelessWidget {
  Enterrecit(this.favorite,this.mesrecettes);

  var favorite;

  var mesrecettes;

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
              MaterialPageRoute(builder: (context) => Home(favorite,mesrecettes)),
            );
          },
        ),
      ),
      
    );
  }
}