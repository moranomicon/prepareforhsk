import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hsk_quiz/screens/stage.dart';
import 'package:hsk_quiz/widgets/button.dart';

class HSKLevelPage extends StatefulWidget {
  @override
  _HSKLevelPageState createState() => _HSKLevelPageState();
}

class _HSKLevelPageState extends State<HSKLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('levels').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData && snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var level in snapshot.data.docs)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LevelPage(
                                          level: level.id.toString())),
                                );
                              },
                              child: Text(
                                level.id.toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18),
                              )),
                        ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
