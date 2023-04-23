import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/paradice_logo.png', // logo de l'appli
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  const Text(
                    "Bienvenue sur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Monoton',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Para'Dice !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ewert',
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 25)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/route2');
                      },
                      child: const Text("Simulation pré-définie"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green))),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/route3');
                    },
                    child: const Text("Simulation personnalisée"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
