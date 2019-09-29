import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  // wrapping the firebase calls
  Future logout() async {
    var result = await FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  Future<AuthResult> loginUser(AuthCredential credential) async {
    try {
      var result = await FirebaseAuth.instance.signInWithCredential(credential);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result;
    }  catch (e) {
      // throw the Firebase AuthException that we caught
      throw new AuthException(e.code, e.message);
    }
  }
}