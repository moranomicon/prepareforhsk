// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hsk_quiz/widgets/choices.dart';

class GamePage extends StatefulWidget {
  GamePage(
      {Key? key,
      required this.gameData,
      required this.level,
      required this.stg});

  final Map gameData;
  final String level;
  final String stg;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int retries = 0;

  List<String> selectedChoices = [];

  showWinDialog(BuildContext context) async {
    int count = 0;
    String fullSentence = widget.gameData['question']
        .replaceAll('[ ]', widget.gameData['answer']);

    var passLevel = Hive.box('PassLevel');

    passLevel.put(widget.level.toUpperCase() + ' - ' + widget.stg, true);

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('levels')
            .doc(widget.level)
            .get();
    var nextQuestion = (documentSnapshot.data() as Map)[(int.parse(widget.stg) + 1).toString()];

    Widget nextButton = TextButton(
      child: Text("Next Stage"),
      onPressed: () async {
        
        Navigator.pop(context);
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => GamePage(
                  gameData: nextQuestion,
                  level: widget.level,
                  stg: (int.parse(widget.stg) + 1).toString())),
        );
      },
    );

    var actions = [okButton];
    if (nextQuestion != null)
      actions.add(nextButton);

    AlertDialog alert = AlertDialog(
      title: Text("Correct!"),
      content: Text(fullSentence),
      actions: actions,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoseDialog(BuildContext context) {
    int count = 0;
    Widget backButton = TextButton(
      child: Text("Back"),
      onPressed: () {
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );
    Widget okButton = TextButton(
      child: Text("Try Again"),
      onPressed: () {
        setState(() {
          retries = 0;
          selectedChoices = [];
        });
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("You Lost!"),
      content: Text("Try again?"),
      actions: [
        backButton,
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void checkCorrectAnswer(choice) {
    if (choice == widget.gameData['answer']) {
      showWinDialog(context);
    } else {
      setState(() {
        retries++;
        selectedChoices.add(choice);
      });
      if (retries == 5) {
        showLoseDialog(context);
      }
    }
  }

  bool checkIfChosenBefore(choice) {
    return selectedChoices.contains(choice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.level.toUpperCase() + ' - ' + widget.stg, style: TextStyle(
                              fontSize: 24)),
        actions: null,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 150,
                            child: Image.asset(
                          'assets/strokes/$retries.png',
                          scale: 0.9,
                          key: UniqueKey(),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          widget.gameData['question'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              wordSpacing: 2.0,
                              letterSpacing: 2.0),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                            height: 200,
                            width: 500,
                            child: GridView.count(
                              crossAxisCount: 5,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 8.0,
                              children: [
                                for (var choice in widget.gameData['choices'])
                                  CustomChoices(
                                    onPressed: () {
                                      !checkIfChosenBefore(choice)
                                          ? checkCorrectAnswer(
                                              choice.toString())
                                          : null;
                                    },
                                    buttonColor: Color(0xffADB3BC),
                                    child: Text(
                                      choice.toString(),
                                      style:  !checkIfChosenBefore(choice) ? TextStyle(fontSize: 36) : TextStyle(fontSize: 36, color: Colors.grey) ,
                                    ),
                                  )
                              ],
                            ))
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
