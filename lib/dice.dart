import 'dart:math';

abstract class Dice {
  // Cette class abstraite permet grâce à ses héritiers de représenter un objet
  // ou plutôt, un dès, de x faces, avec des methodes permettants de le lancer,
  // de récupérer la face sur laquelle il est, ou d'avoir
  //son nombre de faces totales

  // Attributs
  int _nbFace;
  int _resultatFace = 0;

  // Constructeur
  Dice(this._nbFace);

  // Retourne le nombre de faces du dès
  int getnbFace() {
    return this._nbFace;
  }

  // Retourne la face sur laquelle est le dès
  int getresulatFace() {
    return this._resultatFace;
  }

  // Met le dès sur une face donné en paramètre de la méthode.
  void setresultatface(int i) {
    this._resultatFace = i;
  }

  // Permet de simuler un lancé de dès.
  // Génère un chiffre entre 1 et le nombre max de face du dès
  // et applique ce chiffre au résultat de la face
  void lanceDes() {
    int lance = new Random().nextInt(this._nbFace) + 1;
    this._resultatFace = lance;
  }
}
