// import 'package:flutter/material.dart';

// import 'dart:async';


// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqflite.dart';

// import 'presentation.dart';
// import 'lignewidger.dart';

// import 'basededonne.dart';
// import 'entrer_recette.dart';

// void main() async {
//   final dbHelper = Databasefavorie.instance;
//   Future<List> query() async {
//     var tab = [];
//     final allRows = await dbHelper.queryAllRows();

//     allRows.forEach((row) => tab.add(row['clee']));

//     return tab;
//   }

//   Future<List> favorite1;
//   favorite1 = query().then((value) {
//     return value;
//   });

//   var favorite = await favorite1;

//   runApp(MaterialApp(
//     title: 'Flutter Tutorial',
//     home: Home(favorite),
//   ));
// }

// var tab1 = [
//   recette("Croque-monsieur", "1"," ", "assets/croc.jpg"),
//   recette("Tacos mexicains", "2"," ","assets/tacos.jpg"),
//   recette("Gaspacho au Thermomix", "3"," ","assets/gaspacho.jpg"),
//   recette("Tarte au thon", "4"," ","assets/tarte.jpg"),
//   recette("Samoussa rapide au boeuf", "5"," " , "assets/samoussa.jpg"),
//   // recette("test4", "6", null),
// ];

// class recette {
//   recette(this.titre, this.key,this.soustitre ,this.photo);

//   var titre;

//   var soustitre;

//   var photo;

//   var key;
// }

// class Home extends StatelessWidget {
//   Home(this.favorite);

//   var favorite;

//   @override
//   Widget build(BuildContext context) {
//     // Scaffold is a layout for the major Material Components.

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recette de cuisine'),
//         backgroundColor: Color.fromRGBO(240, 88, 93, 1),
//       ),
//       // body is the majority of the screen.
//       body: ListView(
//         padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//         children: tab1
//             .map(
//               (x) => lignehomewidget(x, favorite),
//             )
//             .toList(),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Enterrecit(favorite)),
//           );
//         },
//         child: const Icon(
//           Icons.add,
//         ),
//         backgroundColor: Color.fromRGBO(240, 88, 93, 1),
//       ),

//       drawer: Drawer(
//         // Add a ListView to the drawer. This ensures the user can scroll
//         // through the options in the drawer if there isn't enough vertical
//         // space to fit everything.
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             Container(
//               child: Center(
//                 child: Text('Menu'),
//               ),
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(240, 88, 93, 1),
//               ),
//               height: 100.0,
//             ),
//             ListTile(
//               title: Text('Recettes'),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text('Mes favories'),
//               onTap: () {
//                 // Update the state of the app.
//                 // ...
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// final dummySnapshot = [
//  {"name": "Filip", "votes": 15},
//  {"name": "Abraham", "votes": 14},
//  {"name": "Richard", "votes": 11},
//  {"name": "Ike", "votes": 10},
//  {"name": "Justin", "votes": 1},
// ];

// class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Baby Names',
//      home: MyHomePage(),
//    );
//  }
// }

// class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() {
//    return _MyHomePageState();
//  }
// }

// class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Baby Name Votes')),
//      body: _buildBody(context),
//    );
//  }

// Widget _buildBody(BuildContext context) {
//  return StreamBuilder<QuerySnapshot>(
//    stream: Firestore.instance.collection('baby').snapshots(),
//    builder: (context, snapshot) {
//       if (!snapshot.hasData) return LinearProgressIndicator();

//      return _buildList(context, snapshot.data.documents);
//    },
//  );
// }

//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//  final record = Record.fromSnapshot(data);

//    return Padding(
//      key: ValueKey(record.name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//          title: Text(record.name),
//          trailing: Text(record.votes.toString()),
//          onTap: () => record.reference.updateData({'votes': FieldValue.increment(1)}),
//        ),
//      ),
//    );
//  }
// }

// class Record {
//  final String name;
//  final int votes;
//  final DocumentReference reference;

//  Record.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['name'] != null),
//        assert(map['votes'] != null),
//        name = map['name'],
//        votes = map['votes'];

//  Record.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);

//  @override
//  String toString() => "Record<$name:$votes>";
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final dummySnapshot = [
 {"name": "Filip", "votes": 15},
 {"name": "Abraham", "votes": 14},
 {"name": "Richard", "votes": 11},
 {"name": "Ike", "votes": 10},
 {"name": "Justin", "votes": 1},
 {"name": "test", "votes": 1},
];

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Baby Names',
     home: MyHomePage(),
   );
 }
}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Baby Name Votes')),
     body: _buildBody(context),
   );
 }

 Widget _buildBody(BuildContext context) {
   // TODO: get actual snapshot from Cloud Firestore
   return _buildList(context, dummySnapshot);
 }

 Widget _buildList(BuildContext context, List<Map> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

 Widget _buildListItem(BuildContext context, Map data) {
   final record = Record.fromMap(data);

   return Padding(
     key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.name),
         trailing: Text(record.votes.toString()),
         onTap: () => print(record),
       ),
     ),
   );
 }
}

class Record {
 final String name;
 final int votes;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['votes'] != null),
       name = map['name'],
       votes = map['votes'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 
  String toString() {
    // TODO: implement toString
    return "Record<$name:$votes>";
  }
}




