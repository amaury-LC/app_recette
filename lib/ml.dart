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

  var ingredient = ['tomates','oignon blanc'];
  var search = true;
  var mesrecettes;
  var rechercheRecetteML;
  var rechercheRecetteML_tri = [];


  void searchfunction() {
    setState(() {
      rechercheRecetteML = [];
      
      

      

      search = false;
     var petitnombre = 0;

      for (var i = 0; i < mesrecettes.length; i++) {
         
        for (var y = 0; y < mesrecettes[i]['ingredient'].length; y++) {

         
          

          for (var t = 0; t < ingredient.length; t++) {
            
            if (ingredient[t] == mesrecettes[i]['ingredient'][y]['name']) {
             
              //suprimme une recette deja exitante dans le tableaux

              if (rechercheRecetteML.length != 0) {
                
                for (var j = 0; j < rechercheRecetteML.length; j++) {
                  if (rechercheRecetteML[j]['recette']['name'] ==
                      mesrecettes[i]['name']) {
                  
                    rechercheRecetteML.removeAt(j);
                  }
                }
              }

               print(mesrecettes[i]['name'] + petitnombre.toString() );

               
              rechercheRecetteML.add(

                 
                  
                  {'nombreIngredient': petitnombre++, 'recette': mesrecettes[i]});
            }
            
          
          }

       
                
    
        }

           petitnombre = 0;
      
       
      }
          
      

      // fin boucle




  
      if (rechercheRecetteML.length != 0) {

        rechercheRecetteML.sort((b,a) => a['nombreIngredient'].toString().compareTo(b['nombreIngredient'].toString()));

        

        


         

      }

      // print(rechercheRecetteML);

      

      
      
     

    


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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30.0,
              ),
              iconSize: 30.0,
              onPressed: () {
                searchfunction();
              },
            )
          ],
        ),
        body: search
            ? Center(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  children: ingredient.map<Widget>((x) => Text(x)).toList(),
                ),
              )
            : Center(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  children: rechercheRecetteML
                      .map<Widget>((x) =>Card(
                    child: Column(children: <Widget>[
                  ListTile(
                    title: Text(x['recette']['name']),
                    // subtitle: Text(x['soustitre']),
                    
                    leading: x['recette']['photo'] != null
                        ? Image(
                            image: NetworkImage(x['recette']['photo']),
                           
                          )
                        : Text(""),
                    onTap: () {
                      
               
                      
                      var jsoningredient ;
                      var jsonetape ;
                      if( x['recette']['ingredient'].runtimeType == String){
                       jsoningredient = jsonDecode(x['recette']['ingredient']);
                       jsonetape = jsonDecode(x['recette']['etape']);
                       
                        
                      }
                      Navigator.push(

                          context,
                          MaterialPageRoute(
                              builder: (context) =>

                               x['recette']['ingredient'].runtimeType != String  ?   Recettepresentation(x['recette']['name'], x['recette']['photo'],x['recette']['ingredient'],x['recette']['etape']): Recettepresentation(x['recette']['name'], x['recette']['photo'],jsoningredient,jsonetape)
                                  
                                  
                                  
                                  ));
                      
                    },
                  )
                ])))
            
                      .toList(),
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
              ingredient.add(label);
            });

            //test
          },
          tooltip: 'pick an image',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(240, 88, 93, 1),
        ));
  }
}
