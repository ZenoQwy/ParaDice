import 'dart:io';
import 'package:paradicee/diceperso.dart';
import 'package:flutter/services.dart';

import 'dice.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:paradicee/dicepool10.dart';
import 'package:paradicee/dicepool100.dart';
import 'package:paradicee/dicepool20.dart';
import 'package:paradicee/dicepool6.dart';
import 'package:paradicee/dicepoolPerso.dart';
import 'dicepool.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key, required this.title});
  final String title;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  DicePool lesdes = DicePoolPerso();
  TextEditingController _nbdes = TextEditingController();
  TextEditingController _facedes = TextEditingController();

  Widget listeResultats() {
    Column colonne = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    );
    Row ligne = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    );
    if (lesdes.isEmpty() == false) {
      for (int i = 1; i <= lesdes.getNbFacesOfDicePool(); i++) {
        if (i % 10 == 0) {
          ligne.children.add(Text(
            "nb $i : " + lesdes.getNbrOfOccurrences(i).toString() + " ",
            style: TextStyle(fontSize: 20),
          ));
          colonne.children.add(ligne);
          ligne = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          );
        } /*else if (i % 2 != 0 && i == 10) {
        ligne.children.add(Text("Nb $i : " + lesdes.getNbrOfOccurrences(i).toString()));
        colonne.children.add(ligne);
        ligne = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        );
      }*/
        else {
          ligne.children.add(Text(
            "nb $i : " + lesdes.getNbrOfOccurrences(i).toString() + " ",
            style: TextStyle(fontSize: 20),
          ));
        }
      }
      colonne.children.add(const Padding(padding: EdgeInsets.all(5)));
      colonne.children.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Moyenne : " + lesdes.getAverageOfPool().toStringAsFixed(2),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ));
      return colonne;
    }
    return colonne;
  }

  void _lancerLesDes() {
    setState(() {
      lesdes.roolDiceOfPool();
      print(lesdes.getNbrOfOccurrences(lesdes.getNbFacesOfDicePool()));
    });
  }

  void _ajouterdes() {
    setState(() {
      for (int i = 0; i < int.parse(_nbdes.text); i++) {
        lesdes.addCustomeDiceToPool(DicePerso(int.parse(_facedes.text)));
      }
      lesdes.afficher();
    });
  }

  void _viderlapool() {
    lesdes.resetToZeroDiceInPool();
    lesdes.afficher();
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
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1, // La moitié de la largeur de l'écran
                  height: 40,
                  child: Container(
                    child: TextField(
                      controller: _facedes,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Accepte seulement les nombres
                        FilteringTextInputFormatter.deny("0"), // Refuse la valeur 0
                      ],
                      decoration: InputDecoration(
                        hintText: 'Nombre de faces du dés',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1, // La moitié de la largeur de l'écran
                height: 40,
                child: Container(
                  child: TextField(
                    controller: _nbdes,
                    maxLength: 3,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Accepte seulement les nombres
                      FilteringTextInputFormatter.deny("0"), // Refuse la valeur 0
                    ],
                    decoration: InputDecoration(
                      hintText: 'Quantité de ce dés',
                    ),
                  ),
                ),
              ),
            ]),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _ajouterdes,
                    child: const Text(
                      'Ajouter',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _viderlapool,
                    child: const Text(
                      'Vider la pool',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _lancerLesDes,
        tooltip: 'Commencer',
        backgroundColor: Colors.green,
        child: const Icon(Icons.casino_rounded),
      ),
    );
  }
}
