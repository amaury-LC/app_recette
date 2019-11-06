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

class Mesfavoris extends StatelessWidget {

  Mesfavoris(this.favoris);


  var favoris;

  var test = [{'titre' : 1}, {'titre' : 'test1'}];

  



  @override
  Widget build(BuildContext context) {



    

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes favoris"),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body : ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

        children:  favoris.map<Widget>((x)=>  Text('test')).toList(),

        
      ), 
    

      
    );



  }


}