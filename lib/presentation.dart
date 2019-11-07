import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class Recettepresentation extends StatefulWidget {

  Recettepresentation(this.nom_recette,this.photo_recette);

  
  var nom_recette;
  var photo_recette;

  @override
  Recettepresentationstate createState() => Recettepresentationstate(nom_recette,photo_recette);

}

class Recettepresentationstate extends State {

  Recettepresentationstate(this.nom_recette,this.photo_recette);

  var nom_recette;
  var photo_recette;

 @override
  Widget build(BuildContext context){

     return Scaffold(
      appBar: AppBar(
        title: Text(nom_recette),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body:Column(

        
        
        children: <Widget>[Container(
          
          child: photo_recette != null ? Image(image: NetworkImage(photo_recette),width: 800,) : Text(""),
          
          ),Container( padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8.0), child : Text('Ingrédients' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color.fromRGBO(240, 88, 93, 1),  ),)),

          
          
          
          ],)

      
    );

    



  }

}