import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../network/auth_service.dart';

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
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Enter SMS Code'),
            content: Form(
              key: key,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  this.smsCode = value;
                },
                validator: (String value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Enter valid code';
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  if (key.currentState.validate()) {
                    sign(context);
                    print('smscode: $smsCode');
                  };
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

  void sign(BuildContext context) async {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      if (user != null) {
        print('User $user');
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/homepage');
      } else {
        print('User is null');
        Navigator.of(context).pop();
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

      print('signed in with phone number successful: user -> ${result.user}');
      Navigator.of(context).pushNamed('/homePage');
    } catch (err) {
      print('Mara error');
      this.phoneNo = '+998';
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
                'Enter your phone number',
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
                    textAlign: TextAlign.justify,
                    validator: (String value) {
                      if (value.length == 9) {
                        return null;
                      }
                      return 'Must be 9 characters.';
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      prefixText: '+998 ',
                      hintText: '99 1234567',
                    ),
                    onSaved: (value) {
                      this.phoneNo = this.phoneNo + value;
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
                  } else {
                    //formKey.currentState.reset();
                  }
                },
                child: Text('Login'),
                textColor: Colors.white,
                elevation: 7,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
