import 'package:paradicee/dice6.dart';
import 'package:paradicee/diceperso.dart';
import 'package:paradicee/dicepool.dart';

import 'dice.dart';
import 'dart:io';

class DicePoolPerso extends DicePool {
  @override
  void addDiceToPool() {}

  void addCustomDiceToPool(Dice customDice) {
    pool.add(customDice);
  }

  @override
  int getNbFacesOfDicePool() {
    // TODO: implement getNbFacesOfDicePool
    if (pool.isEmpty == true) {
      return 0;
    } else {
      return pool[0].getnbFace();
    }
  }

  @override
  int getNbrOfOccurrences(int i) {
    List<int> platoccurences = List.generate(1000, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }
}
