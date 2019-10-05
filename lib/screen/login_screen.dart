import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../app.dart';
import '../network/auth_service.dart';
import '../utils/app_localizations.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo = '+998';

  String smsCode;

  String verificationId;

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<FormState>();

  Future<void> verifyPhone(context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential user) {
      print('verified');
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('ENTER_CODE')),
            content: Form(
              key: key,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  this.smsCode = value;
                },
                validator: (String value) {
                  if (value.isEmpty || value.length < 6) {
                    return AppLocalizations.of(context)
                        .translate('ENTER_VALID_CODE');
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  if (key.currentState.validate()) {
                    sign(context);
                  }
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          );
        });
  }

  void sign(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      if (user != null) {
        print('User $user');
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(MyHomePage.routName);
      } else {
        print('User is null');
        loginWithCredential(context);
      }
    });
  }

  void loginWithCredential(BuildContext context) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      AuthResult result =
          await Provider.of<AuthService>(context).loginUser(credential);
      Navigator.of(context).pop();

      FirebaseUser firebaseUser = result.user;
      User user = User(uid: firebaseUser.uid, phoneNumber: firebaseUser.phoneNumber);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(user));

      Navigator.of(context).pushNamed(MyHomePage.routName);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey[200],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('ENTER_PHONE_NUMBER'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    maxLength: 9,
                    textAlign: TextAlign.start,
                    validator: (String value) {
                      if (value.length == 9) {
                        return null;
                      }
                      return AppLocalizations.of(context).translate('PHONE_ERROR_MESSAGE');
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      prefixText: '+998 ',
                      hintText: '99 1234567',
                    ),
                    onSaved: (value) {
                      if (this.phoneNo.length < 13)
                        this.phoneNo = this.phoneNo + value;
                    },
                    onTap: () {
                      this.phoneNo = '+998';
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  bool isValid = formKey.currentState.validate();
                  if (isValid) {
                    formKey.currentState.save();
                    verifyPhone(context);
                    print(this.phoneNo);
                  }
                },
                child: Text(AppLocalizations.of(context).translate('LOGIN')),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
