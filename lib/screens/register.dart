import 'package:flutter/material.dart';
import 'package:hsk_quiz/screens/login.dart';
import 'package:hsk_quiz/services/auth.dart';
import 'package:hsk_quiz/widgets/authButton.dart';
import 'package:hsk_quiz/widgets/emailField.dart';
import 'package:hsk_quiz/widgets/passwordField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final emailFieldController = TextEditingController();
    final passwordFieldController = TextEditingController();
    final passwordConfirmationFieldController = TextEditingController();

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
                    SizedBox(height: 40.0),
                    EmailField(controller: emailFieldController),
                    SizedBox(height: 25.0),
                    PasswordField(
                      controller: passwordFieldController,
                      hintText: 'Password',
                    ),
                    SizedBox(height: 25.0),
                    PasswordField(
                      controller: passwordConfirmationFieldController,
                      hintText: 'Retype Password',
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    AuthButton(
                        onPressed: () async {
                          try {
                            if (passwordFieldController.text !=
                                passwordConfirmationFieldController.text) {
                              throw Exception(
                                  "Your password and confirmation password do not match.");
                            }
                            await _auth.signUp(emailFieldController.text,
                                passwordFieldController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
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
                        text: 'Register'),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    TextButton(
                      child: Text('Login',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
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
