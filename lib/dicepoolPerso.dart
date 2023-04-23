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

  // Cette fonction est inutile dans cette classe
  @override
  int getNbFacesOfDicePool() {
    // TODO: implement getNbFacesOfDicePool
    throw UnimplementedError();
  }
}
