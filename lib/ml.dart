import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_livestream_ml_vision/firebase_livestream_ml_vision.dart';
import 'package:tflite/tflite.dart';

class FacePage extends StatefulWidget {

  FacePage(this.mesrecettes);

  var mesrecettes;
  @override
  createState() => _FacePageState(mesrecettes);
}

class _FacePageState extends State<FacePage> {

  _FacePageState(this.mesrecettes);
  
  var ingredient = ['tomates'] ;
  var search = true;
  var mesrecettes;
  var rechercheRecetteML;

  void searchfunction(){

    setState(() {

      rechercheRecetteML = [];

      var petitnombre = 0;

      search = false;
       for(var i = 0; i < mesrecettes.length ; i++){

        print(i);

         for( var y = 0; y < mesrecettes[i]['ingredient'].length ; y++){

            for(var t = 0 ; t < ingredient.length ; t++){

              if(ingredient[t] == mesrecettes[i]['ingredient'][y]['name']){

                if(!rechercheRecetteML.contains(mesrecettes[i]['name']))

                  rechercheRecetteML.add({'nombreIngredient' : i ,'recette' : mesrecettes[i]['name']});
                }
                

            }




         }



        
       }

     
      
    });


  }

    
  

  @override
  Widget build(BuildContext context) {
    // print('ml recette :');
    // print(mesrecettes[0]['ingredient']);



    return Scaffold(
        appBar: AppBar(
          title: Text('FOODAPP'),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
          actions: <Widget>[IconButton(icon: Icon(Icons.search,color: Colors.white,size: 30.0,),iconSize: 30.0,onPressed: (){searchfunction();},)],
        ),
        
        body: search ? Center(
          child: ListView(
             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              children: ingredient.map<Widget>((x) => Text(x)).toList(),
          ),
        ) : Center(
          child: ListView(
             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              children: rechercheRecetteML.map<Widget>((x) => Text(x['recette']+ " " + x['nombreIngredient'].toString())).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final File imageFile = await ImagePicker.pickImage(
              source: ImageSource.camera,
            );

            Tflite.close();
            try {
              String res = await Tflite.loadModel(
                model: "assets/quant/model_unquant.tflite",
                labels: "assets/quant/labels.txt",
              );
              print(res);
            } on PlatformException {
              print('Failed to load model.');
            }

            var recognitions = await Tflite.runModelOnImage(
                path: imageFile.path, // required
                imageMean: 0.0, // defaults to 117.0
                imageStd: 255.0, // defaults to 1.0
                numResults: 2, // defaults to 5
                threshold: 0.2, // defaults to 0.1
                asynch: true // defaults to true
                );

       
         

            print('camera');
            print(recognitions);

            // String test = recognitions[0].toString();

            setState(() {
              String label = recognitions[0]['label'];
              ingredient.add(label) ;
            });

            //test
          },
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ));
  }
}

