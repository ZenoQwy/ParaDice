import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:paradicee/dicepool10.dart';
import 'package:paradicee/dicepool100.dart';
import 'package:paradicee/dicepool20.dart';
import 'package:paradicee/dicepool6.dart';
import 'dicepool.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.title});
  final String title;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DicePool lesdes = DicePool6();
  TextEditingController _adddes = TextEditingController();

  Widget listeResultats() {
    List<Column> colonnes = [
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
      Column(
        children: [],
      ),
    ];

    int columnIndex = 0;

    for (int i = 1; i <= lesdes.getNbFacesOfDicePool(); i++) {
      if (i % 15 != 0) {
        colonnes[columnIndex].children.add(Text(
              "nb $i : " + lesdes.getNbrOfOccurrences(i).toString() + " ",
              style: TextStyle(fontSize: 9),
            ));
      } else {
        colonnes[columnIndex].children.add(Text(
              "nb ${i} : " + lesdes.getNbrOfOccurrences(i + 1).toString() + " ",
              style: TextStyle(fontSize: 9),
            ));
        columnIndex++;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colonnes,
    );
  }

  void _lancerLesDes() {
    setState(() {
      lesdes.roolDiceOfPool();
    });
  }

  void _ajouterdes() {
    setState(() {
      for (int i = 0; i < int.parse(_adddes.text); i++) {
        lesdes.addDiceToPool();
      }
      lesdes.afficher();
    });
  }

  void _dice6pressed() {
    setState(() {
      lesdes = DicePool6();
      lesdes.addDiceToPool();
      lesdes.afficher();
    });
  }

  void _dice10pressed() {
    setState(() {
      lesdes = DicePool10();
      lesdes.addDiceToPool();
      lesdes.afficher();
    });
  }

  void _dice20pressed() {
    setState(() {
      lesdes = DicePool20();
      lesdes.addDiceToPool();
      lesdes.afficher();
    });
  }

  void _dice100pressed() {
    setState(() {
      lesdes = DicePool100();
      lesdes.addDiceToPool();
      lesdes.afficher();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
            //mainAxisAlignment: MainAxisAlignment.start
            children: <Widget>[
              Container(
                color: Colors.green, // Couleur de fond de la barre
                height: 150, // Hauteur de la barre
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/paradice_logo.png',
                      ),
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: _dice6pressed,
                      child: const Text(
                        'D6',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: _dice10pressed,
                      child: const Text(
                        'D10',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: _dice20pressed,
                      child: const Text(
                        'D20',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: _dice100pressed,
                      child: const Text(
                        'D100',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(5)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2, // La moitié de la largeur de l'écran
                  child: Container(
                    child: TextField(
                      controller: _adddes,
                      maxLength: 3,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'Nombre de dès',
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: _ajouterdes,
                    child: const Text('Ajouter le(s) dès'),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Nombre de dès à ${lesdes.getNbFacesOfDicePool()} faces : ${lesdes.getNbrOfDiceInPool()}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      )),
                ]),
              ),
              Column(children: [listeResultats()]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Moyenne : ${lesdes.getAverageOfPool()}",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ))
              ])
            ]),
        floatingActionButton: FloatingActionButton.small(
          onPressed: _lancerLesDes,
          tooltip: 'Commencer',
          backgroundColor: Colors.green,
          child: const Icon(Icons.casino_rounded),
        ));
  }
}
