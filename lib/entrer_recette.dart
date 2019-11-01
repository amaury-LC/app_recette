import 'package:flutter/material.dart';

import 'dart:async';


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

import 'presentation.dart';
import 'lignewidger.dart';

import 'basededonne.dart';
import 'main.dart';


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