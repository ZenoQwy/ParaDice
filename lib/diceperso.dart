import 'dice.dart';

class DicePerso extends Dice {
  // Constructeur
  DicePerso(int nb) : super(nb);

  // Cette class hérite de la classe mère Dice.
  // Elle permet de représenter un dès à x faces choisi par
  // l'utilisateur en appelant le constructeur
  // de sa classe mère Dice avec un paramètre de x
}
