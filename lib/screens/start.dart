import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hsk_quiz/widgets/button.dart';

import 'level.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initialized = true;
  bool _error = false;
  String error = "";

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Hive.initFlutter();
      await Hive.openBox('PassLevel');

      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Text(error);
    }
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BorderedText(
                strokeWidth: 10.0,
                strokeColor: Colors.white,
                child: Text(
                  'Prepare For',
                  style: TextStyle(
                    fontFamily: 'Architects Daughter',
                      decoration: TextDecoration.none,
                      decorationColor: Colors.white,
                      fontSize: 45),
                ),
              ),
              BorderedText(
                strokeWidth: 10.0,
                strokeColor: Colors.white,
                child: Text(
                  'HSK!',
                  style: TextStyle(
                    fontFamily: 'Architects Daughter',
                      decoration: TextDecoration.none,
                      decorationColor: Colors.white,
                      fontSize: 65)
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
              ),
              DefaultButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HSKLevelPage()),
                  );
                },
                child: const Text(
                  'START',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
