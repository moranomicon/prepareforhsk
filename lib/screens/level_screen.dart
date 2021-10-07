import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hsk_quiz/screens/game_screen.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key? key, required this.stages});

  final Map stages;

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
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
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                        height: 400,
                        width: 500,
                        child: GridView.count(
                          crossAxisCount: 5,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: [
                            for (var level in widget.stages.keys)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GamePage(
                                                question: widget
                                                    .stages[level.toString()])),
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
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
