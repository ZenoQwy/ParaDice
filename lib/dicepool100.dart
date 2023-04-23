import 'package:paradicee/dice.dart';
import 'package:paradicee/dice100.dart';
import 'package:paradicee/dice20.dart';
import 'package:paradicee/dicepool.dart';

class DicePool100 extends DicePool {
  // Ajoute un dès à 6 faces dans la pool de dès ( toujours à la fin de celle-ci ).
  void addDiceToPool() {
    pool.add(Dice100());
  }

  // Retourne le nombre de face des dès de la pool.
  // ( Retourne 100 vu qu'il s'agit d'une pool avec uniquement des
  //dés à 100 faces )
  int getNbFacesOfDicePool() {
    return Dice100().getnbFace();
  }

  // Permet d'avoir le nombre d'occurences de chaque résultats de lancé de dés.
  // Le tableau est oorganisé de manière à ce que l'index correspont au numéro
  // de la face et la valeur associée à elle, au nombre de fois ou le dés est
  // tombé sur cette face.

  // EXEMPLE : Voir la class DicePool6
  @override
  int getNbrOfOccurrencesOfFaceResult(int i, int taille) {
    List<int> platoccurences = List.generate(Dice100().getnbFace() + 1, (index) => 0);
    for (Dice des in this.pool) {
      platoccurences[des.getresulatFace()] = platoccurences[des.getresulatFace()] + 1;
    }
    int result = platoccurences[i];
    print(platoccurences);
    return result;
  }
}
