import 'package:paradicee/dice.dart';
import 'package:paradicee/dice10.dart';
import 'package:paradicee/dice6.dart';
import 'package:paradicee/dicepool.dart';
import 'dart:io';

class DicePool6 extends DicePool {
  // Ajoute un dès à 6 faces dans la pool de dès ( toujours à la fin de celle-ci ).

  void addDiceToPool() {
    pool.add(Dice6());
  }

  // Retourne le nombre de face des dès de la pool.
  // Retourne 6 vu qu'il s'agit d'une pool avec uniquement des dés à 6 faces )
  int getNbFacesOfDicePool() {
    return Dice6().getnbFace();
  }

  // Permet d'avoir le nombre d'occurences de chaque résultats de lancé de dés.
  // Le tableau est oorganisé de manière à ce que l'index correspont au numéro
  // de la face et la valeur associée à elle, au nombre de fois ou le dés est
  // tombé sur cette face.

  // EXEMPLE : Dans une DicePool de 6 on a 4 dés à 6 faces donc.
  // On les lances, on tombe sur 1,5,3,3
  // La fonction va donc retourner un tableau de longueur 7
  // ( car on ne veut pas de l'index 0), comme ceci :

  // nombre d'occurences   : [0,1,0,2,0,1,0]
  // index / faces des dès :  0 1 2 3 4 5 6
  @override
  int getNbrOfOccurrencesOfFaceResult(int i, int taille) {
    List<int> platoccurences = List.generate(Dice6().getnbFace() + 1, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }
}
