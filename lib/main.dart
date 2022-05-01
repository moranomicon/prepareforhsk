import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hsk_quiz/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Text(error);
    }
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'KaiTi',
      ),
      home: LoginPage(),
    );
  }
}
