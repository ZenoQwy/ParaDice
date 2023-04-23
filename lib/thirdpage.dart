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
  TextEditingController _nbdes = TextEditingController(); // récupérer la quatité du des souhaité dans le textfield
  TextEditingController _facedes = TextEditingController(); // récupérer la face du des souhaité dans le textfield

  // LA widget de résultat
  Widget listeResultats() {
    List<Column> colonnes = [
      Column(
        // colonne pour le nb de faces
        children: [],
      ),
      Column(
        // colonnes pour le nom de dés de cette face
        children: [],
      ),
      Column(
        // colonne pour les résultat des dés d'une même face qui ont été lancé
        children: [],
      ),
      Column(
        // colonne pour la moyenne des résultat des dés d'une même face qui ont été lancé
        children: [],
      ),
    ];

    // Entête de chaque colonnes
    colonnes[0].children.add(Text("Nb faces"));
    colonnes[1].children.add(Text("Nb dés"));
    colonnes[2].children.add(Text("Résultat"));
    colonnes[3].children.add(Text("Moyenne"));

    // Parcours du tableau renvoyé par la fonction
    // " getThisPoolWithoutDuplicatedDice " qui me donne donc une réplique
    // de la pool de dés sans avoir deux fois le même dés dedans
    for (int i = 0; i < lesdes.getThisPoolWithoutDuplicatedDice().length; i++) {
      // En se basant sur le tableau sans duplicata de dès de la fonction dit
      // ci dessus, on a juste besoin d'ajouter cela à notre première colonne
      // grâce à l'index de se tableau ( si il y a plusieurs dés différents. )
      colonnes[0].children.add(Text("${lesdes.getThisPoolWithoutDuplicatedDice()[i]}"));

      // Ajout de la quantité de des de la même face à l'aide de la fonction
      // " getNbrOfOccurencesOfFaceDice " prenant en paramètre l'indice
      // du résultat de la fonction " getThisPoolWithoutDuplicatedDice " soit,
      // chaque dès unique present dans la pool de dés
      colonnes[1]
          .children
          .add(Text("${lesdes.getNbrOfOccurencesOfFaceDice(lesdes.getThisPoolWithoutDuplicatedDice()[i])}"));

      // Ajout des résultats de chaque lancé des dés à x faces grâce à la fonction
      // " getResultatFaceOfSpecificDice " prenant en paramètre du résultat
      // de la fonction (List<int>) " getThisPoolWithoutDuplicatedDice "
      colonnes[2]
          .children
          .add(Text("${lesdes.getResultatFaceOfSpecificDice(lesdes.getThisPoolWithoutDuplicatedDice()[i])}"));
      double moyenne = 0;

      // Affichage de la moyenne dans la 4eme colonne
      // Pour chaque résultat de lancé de dés unique présent dans la pool de dés
      for (int y = 0;
          y < lesdes.getResultatFaceOfSpecificDice(lesdes.getThisPoolWithoutDuplicatedDice()[i]).length;
          y++) {
        // On additionne touts les résultats de lancé de dés uniques entre eux
        moyenne += lesdes.getResultatFaceOfSpecificDice(lesdes.getThisPoolWithoutDuplicatedDice()[i])[y];
      }
      // On divise le tout par le nombre de dés unique pour chacunes des faces
      moyenne /= lesdes.getResultatFaceOfSpecificDice(lesdes.getThisPoolWithoutDuplicatedDice()[i]).length;
      // Ajout de ce résultat dans la 4eme colonne ( arondi à 1 apres la virgule )
      colonnes[3].children.add(Text("${moyenne.toStringAsFixed(1)}"));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colonnes,
    );
  }

  // La fonction du FloatingButton qui permet de lancer les des de la DicePool
  void _lancerLesDes() {
    setState(() {
      lesdes.roolDiceOfPool();
    });
  }

  // Ajout de dés dans la DicePool à l'aide d'une saisie utilisateur prenant en
  // compte le nombre de face du dés à ajouter et sa quantité.
  void _ajouterdes() {
    setState(() {
      for (int i = 0; i < int.parse(_nbdes.text); i++) {
        lesdes.addCustomeDiceToPool(DicePerso(int.parse(_facedes.text)));
      }
      lesdes.afficher();
    });
  }

  // Vide totalement la dicepool
  void _viderlapool() {
    setState(() {
      lesdes.resetToZeroDiceInPool(); // Fonction permettant cela
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
                      'assets/images/paradice_logo.png', // Le logo de l'appli
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
                      maxLength: 3, // Limite à entrer un nombre à 3 chiffres max
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Accepte seulement les nombres
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^[1-9][0-9]*$')) // Permet d'interdire uniquement la valeur 0 seule mais pas les chiffres composés de 0 comme 10, 20 ,30 etc ..
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
                      FilteringTextInputFormatter.allow(RegExp(
                          r'^[1-9][0-9]*$')) // Permet d'interdire uniquement la valeur 0 seule mais pas les chiffres composés de 0 comme 10, 20 ,30 etc ..
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
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Les résultats :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(children: [listeResultats()]),
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
