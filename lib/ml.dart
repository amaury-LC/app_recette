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
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';






class FacePage extends StatefulWidget{


   

  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {

    File _imageFile;

    List<Face> _faces;

    void _getImageAndDetectFaces() async {

     final imageFile = await ImagePicker.pickImage(
              source: ImageSource.gallery,
                  
            );
      final image = FirebaseVisionImage.fromFile(imageFile);
      final faceDetector = FirebaseVision.instance.faceDetector(

              FaceDetectorOptions(

                mode: FaceDetectorMode.accurate,
              )
            );
            
             final faces = await faceDetector.detectInImage(image);
          if(mounted){
            setState(() {
              _imageFile = imageFile;
              _faces = faces;
            });

          }
     



  }



 
  @override
  Widget build(BuildContext context){

 



    return Scaffold(

      appBar: AppBar(
         title: Text('FOODAPP'),
         backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ),

        body: Container(),

        floatingActionButton: FloatingActionButton(

          onPressed: _getImageAndDetectFaces,
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),

        )
          

        




    );
  }
}


class ImagesAndFaces extends StatelessWidget {

  ImagesAndFaces({this.imageFile,this.faces});
  
  final  File imageFile;

  final  List<Face> faces;

  @override
  Widget build(BuildContext){
    return Column(children: <Widget>[

      Flexible(

        flex: 2,
        child : Container(

          constraints: BoxConstraints.expand(),

          child:  Image.file(
          imageFile,
          fit: BoxFit.cover,
        ),
      ),
        ),
        
      Flexible(

        flex: 1,

        child: ListView(

          children: faces.map<Widget>((f) => FacesCoordinates(f)).toList(),
        ),

      )

    ],);
  }
}


class FacesCoordinates extends StatelessWidget {

  FacesCoordinates(this.face);


  final Face face;

  @override

  Widget build(BuildContext context){

    final pos = face.boundingBox;
    return ListTile(

      title: Text('(${pos.top}, ${pos.left}), (${pos.bottom}, ${pos.right})') ,


    );
  }


}