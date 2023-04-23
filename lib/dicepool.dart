import 'dice.dart';
import 'dart:io';

abstract class DicePool {
  // Attribut
  List<Dice> pool = [];

  // Aucun constructeur nécessaire.

  // Ajoute un dès dans la pool de dès ( tojours à la fin de celle-ci ).
  void addDiceToPool();

  void addCustomeDiceToPool(Dice des) {
    this.pool.add(des);
  }

  bool isEmpty() {
    if (this.pool.length == 0) {
      return true;
    } else {
      return false;
    }
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

  // Remet la pool de dès à zéro dès dans celle-ci.
  void resetToZeroDiceInPool() {
    for (int i = 0; i < this.pool.length; i++) {
      while (this.pool.length > 0) {
        this.pool.remove(pool[0]);
      }
    }
  }

  // Retourne le nombre de dès dans la pool de dès
  int getNbrOfDiceInPool() {
    return this.pool.length;
  }

  // Permet de lancer touts les dès de la pool
  void roolDiceOfPool() {
    for (Dice des in this.pool) {
      des.lanceDes();
    }
  }

  // Retourne un tableau avec le nombre de fois que chaque dès
  // est tombé sur une face x
  int getNbrOfOccurrences(int i);

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
