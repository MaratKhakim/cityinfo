import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'network/auth_service.dart';
import 'screen/login_screen.dart';
import 'widget/loading_circle.dart';
import 'screen/service_list_screen.dart';
import 'screen/profile_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    child: MyApp(),
    builder: (BuildContext context) => AuthService(),
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            //return snapshot.hasData ? MyHomePage() : LoginScreen();
            return MyHomePage();
          } else {
            return LoadingCircle();
          }
        },
      ),
      initialRoute: '/',
      routes: {
        MyHomePage.routName: (context) => MyHomePage(),
        LoginScreen.routName: (context) => LoginScreen(),
        ServiceListScreen.routName: (context) => ServiceListScreen(),
        ProfileScreen.routName: (context) => ProfileScreen(),
      },
    );
  }
}