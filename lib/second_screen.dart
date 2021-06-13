import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String name;

  SecondScreen({required this.name});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> users = <String>[
    'Waleed',
    'Hamza',
    'Ali',
    'Umar',
    'Akbar',
    'Waleed',
    'Hamza',
    'Ali',
    'Umar',
    'Akbar',
    'Waleed',
    'Hamza',
    'Ali',
    'Umar',
    'Akbar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body:

//        ListView(
//          scrollDirection: Axis.horizontal,
//          children: users.map((e) => Text(e)).toList(),
//        )

      ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          var firstLetter = user[0];
          return ListTile(
            title: Text(user),
            leading: CircleAvatar(
              child: Text(firstLetter),
            ),
          );
        },
      ),

//      ListView(
//        children: users
//            .map(
//              (e) => ListTile(
//                title: Text(e),
//                leading: CircleAvatar(
//                  child: Text(e[0]),
//                ),
//              ),
//            )
//            .toList(),
//      ),
        );
  }
}
