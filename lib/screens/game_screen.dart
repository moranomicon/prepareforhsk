import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key, required this.question});

  final Map question;
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int retries = 0;

  showWinDialog(BuildContext context) {
    int count = 0;
    String fullSentence = widget.question['question']
        .replaceAll('[ ]', widget.question['answer']);
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Correct!"),
      content: Text(fullSentence),
      actions: [
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
    if (choice == widget.question['answer']) {
      showWinDialog(context);
    } else {
      setState(() {
        retries++;
      });
      if (retries == 5) {
        showLoseDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HSK 1 - 5'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_alert),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      ]),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage('background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Image.asset(
                  'assets/strokes/$retries.png',
                  key: UniqueKey(),
                )),
                Text(
                  widget.question['question'],
                  style: TextStyle(
                      fontSize: 32, wordSpacing: 2.0, letterSpacing: 2.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                    height: 400,
                    width: 500,
                    child: GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      children: [
                        for (var choice in widget.question['choices'])
                          ElevatedButton(
                            onPressed: () {
                              checkCorrectAnswer(choice.toString());
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                            child: Text(
                              choice.toString(),
                              style: TextStyle(fontSize: 36),
                            ),
                          )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
