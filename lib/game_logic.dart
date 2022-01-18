import 'dart:math';

class Game {
  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (!(Player.playersX.contains(i) || Player.playersO.contains(i))) {
        emptyCells.add(i);
      }
    }
    if (Player.playersX.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playersX.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playersX.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playersX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playersX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playersX.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playersX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playersX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }

    playGame(index, activePlayer);
  }

  String checkWinners() {
    String winner = '';
    if (Player.playersX.containsAll(0, 1, 2) ||
        Player.playersX.containsAll(3, 4, 5) ||
        Player.playersX.containsAll(6, 7, 8) ||
        Player.playersX.containsAll(1, 4, 7) ||
        Player.playersX.containsAll(0, 3, 6) ||
        Player.playersX.containsAll(2, 5, 8) ||
        Player.playersX.containsAll(0, 4, 8) ||
        Player.playersX.containsAll(2, 4, 6)) {
      winner = 'x';
    } else if (Player.playersO.containsAll(0, 1, 2) ||
        Player.playersO.containsAll(3, 4, 5) ||
        Player.playersO.containsAll(6, 7, 8) ||
        Player.playersO.containsAll(1, 4, 7) ||
        Player.playersO.containsAll(0, 3, 6) ||
        Player.playersO.containsAll(2, 5, 8) ||
        Player.playersO.containsAll(0, 4, 8) ||
        Player.playersO.containsAll(2, 4, 6)) {
      winner = 'o';
    } else {
      winner = '';
    }
    return winner;
  }

  void playGame(int index, String activePlayer) {
    if (activePlayer == 'x') {
      Player.playersX.add(index);
    } else {
      Player.playersO.add(index);
    }
  }
}

class Player {
  static const x = 'x';
  static const o = 'o';
  static const empty = '';
  static List<int> playersX = [];
  static List<int> playersO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    return contains(x) && contains(y) && contains(z);
  }
}
