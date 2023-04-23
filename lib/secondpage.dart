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

  // J'ai divisé l'affichage des résultats en colonnes afin que celui'ci soit
  // adapté pour l'affichage des résultats d'une DicePool100
  // ( 15 résultats par colonnes )
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

    // Parcours de la pool de 0 à sa longueur max
    // ( qui est en soit = au nombre de face des dès de la pool ) étant donné
    // que celle-ci contientra toujours des dés de même face.
    for (int i = 1; i <= lesdes.getNbFacesOfDicePool(); i++) {
      // si le nombre de la face est < 15
      if (i % 15 != 0) {
        // On ajoute les résultats de chaque face de 1 à 14 dans la 1ere colonne
        colonnes[columnIndex].children.add(Text(
              "nb $i : " + lesdes.getNbrOfOccurrencesOfFaceResult(i, 0).toString() + " ",
              style: TextStyle(fontSize: 9),
            ));
      } else {
        // si le nombre de résultat est de 15 ou plus
        // On ajoute le dernier résultat pour la face 15 dans la 1ere colonne
        colonnes[columnIndex].children.add(Text(
              "nb ${i} : " + lesdes.getNbrOfOccurrencesOfFaceResult(i + 1, 0).toString() + " ",
              style: TextStyle(fontSize: 9),
            ));
        // On passe à la colonne suivante.
        columnIndex++;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colonnes,
    );
  }

  // Fonction du FloatingButton permettant de lancer touts les dés de la pool
  void _lancerLesDes() {
    setState(() {
      lesdes.roolDiceOfPool();
    });
  }

  // Fonction qui ajoute un nombre x définis par une saisie de l'utilisateur
  // grâce à un TextField.
  // Le dés ajouté aura automatiquement le même nombre de fâce que la pool
  // actuelle. Si la DicePool = DicePool 20, ca ajoutera un dés à 20 faces.
  void _ajouterdes() {
    setState(() {
      for (int i = 0; i < int.parse(_adddes.text); i++) {
        lesdes.addDiceToPool();
      }
      lesdes.afficher();
    });
  }

  // Change la DicePool actuelle par une DicePool de 6
  void _dice6pressed() {
    setState(() {
      lesdes = DicePool6();
    });
  }

  // Change la DicePool actuelle par une DicePool de 10
  void _dice10pressed() {
    setState(() {
      lesdes = DicePool10();
    });
  }

  // Change la DicePool actuelle par une DicePool de 20
  void _dice20pressed() {
    setState(() {
      lesdes = DicePool20();
    });
  }

  // Change la DicePool actuelle par une DicePool de 100
  void _dice100pressed() {
    setState(() {
      lesdes = DicePool100();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          Container(
            color: Colors.green, // Couleur de fond de la barre
            height: 150, // Hauteur de la barre
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/paradice_logo.png', // Logo de l'appli
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
                  maxLength: 3, // Limite à entrer un nombre à 3 chiffres max
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^[1-9][0-9]*$')) // Permet d'interdire uniquement la valeur 0 seule mais pas les chiffres composés de 0 comme 10, 20 ,30 etc ..
                  ],
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
