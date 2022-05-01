import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hsk_quiz/screens/register.dart';
import 'package:hsk_quiz/screens/start.dart';
import 'package:hsk_quiz/services/auth.dart';
import 'package:hsk_quiz/widgets/authButton.dart';
import 'package:hsk_quiz/widgets/emailField.dart';
import 'package:hsk_quiz/widgets/passwordField.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final emailFieldController = TextEditingController();
    final passwordFieldController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/strokes/5.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    EmailField(controller: emailFieldController),
                    SizedBox(height: 25.0),
                    PasswordField(
                      controller: passwordFieldController,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    AuthButton(
                        onPressed: () async {
                          try {
                            await _auth.signIn(emailFieldController.text,
                                passwordFieldController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        title: 'HSK Start Page',
                                      )),
                            );
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        text: 'Login'),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    TextButton(
                      child: Text('Register', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
