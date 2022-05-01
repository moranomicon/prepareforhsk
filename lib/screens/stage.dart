import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hsk_quiz/screens/game.dart';
import 'package:hsk_quiz/widgets/choices.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key? key, required this.level});

  final String level;

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
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
            stream: FirebaseFirestore.instance
                .collection('levels')
                .doc(widget.level)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData && snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                Map<String, dynamic> doc =
                    snapshot.data.data() as Map<String, dynamic>;
                var newMap = Map.fromEntries(doc.entries.toList()
                  ..sort((e1, e2) => compareNatural(e1.key, e2.key)));

                var passLevel = Hive.box('PassLevel');
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
                            for (var key in newMap.keys)
                              CustomChoices(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GamePage(
                                              gameData: newMap[key.toString()], level: widget.level, stg: key.toString())),
                                    );
                                    setState(() {
                                      
                                    });
                                  },
                                  buttonColor: Color(0xff738FA7),
                                  child: Text(
                                    key.toString(),
                                    style: passLevel.get(widget.level.toUpperCase() + ' - ' + key.toString()) == true ?  TextStyle(fontSize: 25, color: Color(0xffB9B7BD)) : TextStyle(fontSize: 25, color: Colors.white)  ,
                                  )),
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
