import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'network/auth_service.dart';
import 'screen/login_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/service_list_screen.dart';
import 'utils/app_localizations.dart';
import 'widget/loading_circle.dart';

void main() => runApp(
      ChangeNotifierProvider(
        child: MyApp(),
        builder: (BuildContext context) => AuthService(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'handbook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2D5E89),
      ),
      supportedLocales: [
        Locale('ru'),
        Locale('en'),
        Locale('uz'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              return Text(snapshot.error.toString());
            }

            //if (!snapshot.hasData) return LoginScreen();

            return MyHomePage();
          } else {
            return Scaffold(
              body: LoadingCircle(),
            );
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
