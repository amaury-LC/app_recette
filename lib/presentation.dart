import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
// var ingredient1 = ['test','test1','test3'];
class Recettepresentation extends StatefulWidget {

  Recettepresentation(this.nom_recette,this.photo_recette,this.ingredient,this.etape);

  
  var nom_recette;
  var photo_recette;
  var ingredient;
  var etape;
 

  @override
  Recettepresentationstate createState() => Recettepresentationstate(nom_recette,photo_recette,ingredient,etape);
  
}

class Recettepresentationstate extends State {

  Recettepresentationstate(this.nom_recette,this.photo_recette,this.ingredient,this.etape);

  var nom_recette;
  var photo_recette;
  var ingredient;
  var etape;

 @override
  Widget build(BuildContext context){

    print('test');
    print(ingredient);

     return Scaffold(
      appBar: AppBar(
        title: Text(nom_recette),
        backgroundColor: Color.fromRGBO(240, 88, 93, 1),
      ),
      // body is the majority of the screen.
      body:ListView(

        
        
        children: <Widget>[Container(
          
          child: photo_recette != null ? Image(image: NetworkImage(photo_recette),width: 800,) : Text(""),
          
          
          ),

          Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  <Widget>[Center( child : Container( padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child : Text('Ingrédients' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color.fromRGBO(240, 88, 93, 1),  ),))),]+ingredient.map<Widget>((list)=> ListTile(
          title: Text(list['name']),
          enabled: false,
          trailing: Text(list['nombre']),
        )).toList(),

      )),
       Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  <Widget>[Center( child : Container( padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child : Text('Etape' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color.fromRGBO(240, 88, 93, 1)),  ),)),]+etape.map<Widget>((list1)=> ListTile(
          title: Container( margin: const EdgeInsets.only(bottom: 20.0), child:Text(list1['etape'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(240, 88, 93, 1)))),
          subtitle: Text(list1['instruction']),
          enabled: false,
          
        )).toList(),

      ))

          
          
          
          ],)

      
    );

    



  }

}