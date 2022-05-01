import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future signUp(email, password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        var newUser = result.user;

        var bytes = utf8.encode(password);
        var digest = sha1.convert(bytes);

        FirebaseFirestore.instance
            .collection('users')
            .doc(newUser!.uid)
            .set({'email': newUser.email, 'password': digest.toString()});
      });
    } catch (e) {
      throw e;
    }
  }

  Future signIn(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }
}
