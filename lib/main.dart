import 'package:flutter/material.dart';

import 'splashscreen.dart';
import 'firstpage.dart';
import 'secondpage.dart';
import 'thirdpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParaDice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Paradice navigation'),
      routes: <String, WidgetBuilder>{
        '/route1': (BuildContext context) => FirstPage(title: "Bienvenue"),
        '/route2': (BuildContext context) => SecondPage(title: 'Simulation pré-définie'),
        '/route3': (BuildContext context) => ThirdPage(title: 'Simulation personnalisée'),
      },
    );
  }
}
