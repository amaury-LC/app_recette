import 'package:flutter/material.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'presentation.dart';
import 'basededonne.dart';


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
