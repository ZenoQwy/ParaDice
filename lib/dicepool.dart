import 'dart:ffi';

import 'dice.dart';
import 'dart:io';

abstract class DicePool {
  // Attribut
  List<Dice> pool = [];

  // Aucun constructeur nécessaire.

  // Ajoute un dès dans la pool de dès ( tojours à la fin de celle-ci ).
  void addDiceToPool();

  // Ajouter un dès de x faces choisi par l'utilisateur à la pool
  void addCustomeDiceToPool(Dice des) {
    this.pool.add(des);
  }

  // Permet de savoir si la dicepool est vide ou non
  bool isEmpty() {
    if (this.pool.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  // Permet de trouver et de retourner le dés qui a le plus grand nombre de
  // face dans la pool
  int getMaxFaceInPoolPerso() {
    int result = 0;
    for (Dice des in pool) {
      if (des.getnbFace() > result) {
        result = des.getnbFace();
      }
    }
    return result;
  }

  // Permet de savoir le nombre de face des dès dans une
  // DicePool6,10,20,100
  int getNbFacesOfDicePool();

  // Retire un dès au début de la pool de dès
  void removeDiceToPool() {
    this.pool.remove(pool[0]);
  }

  // Retire un dès dans au début de la pool de dès
  // mais conserve un dès dans la pool afin d'éviter
  // un out of range
  void removeDiceToPoolUntilOne() {
    if (this.pool.length > 1) {
      this.pool.remove(pool[0]);
    }
  }

  // Remet la pool de dès à un dès dans celle-ci.
  void resetToOneDiceInPool() {
    for (int i = 0; i < this.pool.length; i++) {
      while (this.pool.length > 1) {
        this.pool.remove(pool[0]);
      }
    }
  }

  // Vide entièrement la pool de dés.
  void resetToZeroDiceInPool() {
    for (int i = 0; i < this.pool.length; i++) {
      while (this.pool.length > 0) {
        this.pool.remove(pool[0]);
      }
    }
  }

  // Retourne le nombre de dés dans la pool de dès
  int getNbrOfDiceInPool() {
    return this.pool.length;
  }

  // Permet de lancer touts les dés de la pool
  void roolDiceOfPool() {
    for (Dice des in this.pool) {
      des.lanceDes();
    }
  }

  // Retourne la valeur d'un tableau correspondant au nombre d'occurences
  // qu'un dés est tombé sur une face.
  int getNbrOfOccurrencesOfFaceResult(int i, int taille) {
    List<int> platoccurences = List.generate(taille + 1, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }

  // Permet de calculer et de retourner un nombre correspondant
  // au nombre de dés de même face.
  // EXEMPLE : Si il y 3 dés à 49 faces dans la pool,
  // la fonction vous retournera 3
  int getNbrOfOccurencesOfFaceDice(int nbfacedes) {
    int result = 0;
    for (Dice des in this.pool) {
      if (des.getnbFace() == nbfacedes) {
        result += 1;
      }
    }
    return result;
  }

  // Permet de renvoyer une list de int correspondant au nombre de face
  // de chaque dés sans duplicata
  // ExEMPLE : Si il y 3 dés à 49 faces et 1 dés à 12 faces dans la pool,
  // la fonction vous retournera : [49,12] au lieu de  [49,49,49,12]
  List<int> getThisPoolWithoutDuplicatedDice() {
    List<int> result = [];
    int uniqueNumber = 0;
    for (int i = 0; i < pool.length; i++) {
      if (!(result.contains(pool[i].getnbFace()))) {
        result.add(pool[i].getnbFace());
      }
    }
    return result;
  }

  // Retourne la face sur laquelle est tombé le dés donné en paramètre,
  // reconnu par son nombre de faces.
  List<int> getResultatFaceOfSpecificDice(int faceOfTheDice) {
    List<int> result = [];
    for (Dice des in pool) {
      if (des.getnbFace() == faceOfTheDice) {
        result.add(des.getresulatFace());
      }
    }
    return result;
  }

  // Permet de calculer et de renvoyer la moyenne de la pool de dès
  // en fonction du résultat de chaque dès après leur lancé
  double getAverageOfPool() {
    double result = 0;
    for (Dice des in pool) {
      result += des.getresulatFace();
    }
    result /= this.pool.length;
    return double.parse(result.toStringAsFixed(2));
  }

  // Fonction de test permmettant de visualiser la pool de dès
  void afficher() {
    String rep = "";
    String repp = "";
    for (Dice des in this.pool) {
      rep += "🎲 ";
      repp += "${des.getnbFace()} ";
    }
    print(rep);
    print(repp);
  }
}
