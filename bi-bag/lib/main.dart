import 'package:flutter/material.dart';
import 'package:hello_word/provider/DataRequestProvider.dart';
import 'package:hello_word/ui/DashboardPage.dart';
import 'package:provider/provider.dart';

import 'model/User.dart';
import 'provider/AuthProvider.dart';
import 'provider/UserProvider.dart';
import 'ui/welcome/SplashPage.dart';
import 'util/UserPreferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => DataRequestProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: SplashPage()));

    /*FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.data.token == null) {
                        UserPreferences().removeUser();
                        return SplashPage();
                      } else {
                        return DashboardPage();
                      }
                  }
                })));*/
  }
}
