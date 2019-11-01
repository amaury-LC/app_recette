import 'package:flutter/material.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

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
          
          ),Container( padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8.0), child : Text('Ingrédients' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color.fromRGBO(240, 88, 93, 1),  ),)),

          
          
          
          ],)

      
    );

    



  }

}