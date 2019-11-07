import 'package:flutter/material.dart';
import 'package:fluttertest/main.dart';
import 'package:fluttertest/main.dart' as prefix0;

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'presentation.dart';
import 'basededonne.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class lignehomewidget extends StatefulWidget {
  lignehomewidget(this.x, this.favorite);

  var x;

  var favorite;

  @override
  Lignehome createState() => Lignehome(x, favorite);
}

class Lignehome extends State {
  Lignehome(this.x, this.favorite);

  DocumentSnapshot x;

  List favorite;

  

  

  void changement(id,nom,photo,soustitre) {
    setState(() {
      final dbHelper = Databasefavorie.instance;

      void _insert(clee,nom,soustitre,photo) async {
        await dbHelper.insert(clee,nom,soustitre,photo);


      }

      void _delete(clee) async {
        // Assuming that the number of rows is the id for the last row.

        await dbHelper.delete(clee);
      }

      // _insert();

      // _delete();

     
        
        
        

      
      if (!favorite.contains(id)) {
        favorite.add(id);
        _insert(id,nom,photo,soustitre);
        mesfavoris.add({'id': id,'name': nom,'photo' : photo,'soustitre' : soustitre});
        print('insert');
        print(mesfavoris);
      } else {
        favorite.remove(id);
        _delete(id);
        for(var i = 0 ; i < mesfavoris.length; i++){

          if(mesfavoris[i]['id'] == id)

          mesfavoris.removeAt(i);
        }
        print('delete');
        print(mesfavoris);
      }


    });
  }

  @override
  Widget build(BuildContext context){

    final record = Record.fromSnapshot(x);

    // print('test1');

    // print(record.reference.documentID);

   

    return Card( 

      child: Column(
        children: <Widget>[ListTile(

          title: Text(record.name),
      subtitle: Text(record.soustitre) ,
      trailing: IconButton(
        icon: Icon(
          favorite.contains(record.reference.documentID) ? Icons.favorite : Icons.favorite_border,
          color:  favorite.contains(record.reference.documentID) ? Colors.red : null,
        ),
        onPressed: () {
          changement(record.reference.documentID,record.name,record.photo,record.soustitre);
        },
      ),
      onTap: () {
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Recettepresentation(record.name,record.photo)));
      },
      
      leading:  record.photo!= null ? Image(image: NetworkImage(record.photo)) : Text(""),
          
        
    

        )],
      )

    );


  }
}

// Container (
//        child: x.photo != null ? Image(image: AssetImage(x.photo),height: 100,) : Text(""),
        
//       ),





class Record {
 final String name;
 final String photo;
 final String soustitre ;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['photo'] != null),
       assert(map['soustitre'] != null),
       name = map['name'],
       photo = map['photo'],
       soustitre = map['soustitre'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$photo>";
}