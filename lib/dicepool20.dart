import 'package:paradicee/dice.dart';
import 'package:paradicee/dice20.dart';
import 'package:paradicee/dicepool.dart';

class DicePool20 extends DicePool {
  // Ajoute un dès à 6 faces dans la pool de dès ( toujours à la fin de celle-ci ).
  void addDiceToPool() {
    pool.add(Dice20());
  }

  int getNbFacesOfDicePool() {
    return Dice20().getnbFace();
  }

  @override
  int getNbrOfOccurrences(int i) {
    List<int> platoccurences = List.generate(Dice20().getnbFace() + 1, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }
}
