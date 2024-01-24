// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:test_screen_change/sqlite_test/db_helper.dart';
// import 'package:test_screen_change/sqlite_test/model/dog_model.dart';

// final String TableName = 'Dog';

// class SqliteScreen extends StatefulWidget {
//   const SqliteScreen({super.key});

//   @override
//   State<SqliteScreen> createState() => _SqliteScreenState();
// }

// class _SqliteScreenState extends State<SqliteScreen> {
//   List<Dog> dogs = [
//   Dog(name: '푸들이'),
//   Dog(name: '삽살이'),
//   Dog(name: '말티말티'),
//   Dog(name: '강돌이'),
//   Dog(name: '진져'),
//   Dog(name: '백구'),
// ];


//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: DBHelper().getAllDogs(),
//         builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {

//           if(snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Dog item = snapshot.data[index];
//                 return Dismissible(
//                   key: UniqueKey(),
//                   onDismissed: (direction) {
//                     DBHelper().deleteDog(item.id);
//                     setState(() {});
//                   },
//                   child: Center(child: Text(item.name)),
//                 );
//               },
//             );
//           }
//           else
//           {
//             return Center(child: CircularProgressIndicator(),);
//           }
//         });
//   }
// }
