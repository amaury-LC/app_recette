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
  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  // FirebaseVision _vision;
  var text1 = "test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FOODAPP'),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ),
        body: Center(
          child: Text(text1),
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

            // var recognitions = await Tflite.detectObjectOnImage(
            //     path: imageFile.path, // required
            //     model: "SSDMobileNet",
            //     imageMean: 127.5,
            //     imageStd: 127.5,
            //     threshold: 0.4, // defaults to 0.1
            //     numResultsPerClass: 2, // defaults to 5
            //     asynch: true // defaults to true
            //     );

            print('camera');
            print(recognitions);

            // String test = recognitions[0].toString();

            setState(() {
              text1 = recognitions[0]['label'];
            });

            //test
          },
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ));
  }
}
