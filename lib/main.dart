import 'package:euclid/configs/AmplifyService.dart';
import 'package:euclid/screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Euclid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return LoginScreen();
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }

  Future<dynamic> init() async {
    AmplifyService.configureAmplify();
    return await Firebase.initializeApp();
  }
}
