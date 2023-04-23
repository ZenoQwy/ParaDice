import 'package:paradicee/dice.dart';
import 'package:paradicee/dice6.dart';
import 'package:paradicee/dicepool.dart';
import 'dart:io';

class DicePool6 extends DicePool {
  // Ajoute un dès à 6 faces dans la pool de dès ( toujours à la fin de celle-ci ).

  void addDiceToPool() {
    pool.add(Dice6());
  }

  int getNbFacesOfDicePool() {
    return Dice6().getnbFace();
  }

  @override
  int getNbrOfOccurrences(int i) {
    List<int> platoccurences = List.generate(Dice6().getnbFace() + 1, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }
}
