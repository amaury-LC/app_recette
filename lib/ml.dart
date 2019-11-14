import 'dart:io';

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
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';







class FacePage extends StatefulWidget{


   

  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {

    

 
  @override
  Widget build(BuildContext context){

    



    return Scaffold(

      appBar: AppBar(
         title: Text('FOODAPP'),
         backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ),

        

        floatingActionButton: FloatingActionButton(

          onPressed: (){
            
          },
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),

        )
          

        




    );
  }
}





