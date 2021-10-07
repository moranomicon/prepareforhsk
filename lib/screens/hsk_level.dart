import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hsk_quiz/screens/level_screen.dart';

class HSKLevelPage extends StatefulWidget {
  @override
  _HSKLevelPageState createState() => _HSKLevelPageState();
}

class _HSKLevelPageState extends State<HSKLevelPage> {
  Future<Map> getStages() async {
    final String response =
        await rootBundle.loadString('assets/questions/quiz.json');
    final data = await json.decode(response);
    return data['level'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: AssetImage('background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Map<dynamic, dynamic>>(
            future: getStages(),
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
                      for (var level in snapshot.data?.keys)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LevelPage(
                                          stages:
                                              snapshot.data[level.toString()])),
                                );
                              },
                              child: Text(
                                level.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
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
