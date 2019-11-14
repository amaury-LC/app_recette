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
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class FacePage extends StatefulWidget {

  
  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {

  var text1 = "test";


  


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FOODAPP'),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ),
        body : Center(child: Text(text1),),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  async{
            final File imageFile = await ImagePicker.pickImage(
              source: ImageSource.camera,
            );

            final FirebaseVisionImage visionImage =
                FirebaseVisionImage.fromFile(imageFile);

            final ImageLabeler labeler = FirebaseVision.instance.imageLabeler(
              ImageLabelerOptions(confidenceThreshold: 0.75),
            );

            final List<ImageLabel> labels =
                await labeler.processImage(visionImage);

            for (ImageLabel label in labels) {
               
              final String text = label.text;
              print('test photo text');

              setState(() {
              text1 = text;
            });
              
              print(text);
              final String entityId = label.entityId;
              print('test photo entite');
              print(entityId);
              final double confidence = label.confidence;
              print('test photo confidence');
              print(confidence);
            }

             labeler.close();

           



            
            
            // // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);

            // // print('photo');

            // // print(visionImage);
          },
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ));
  }
}
