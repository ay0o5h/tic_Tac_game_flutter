import 'package:flutter/material.dart';

import 'game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'x';
  bool isFinished = false;
  bool isSwitched = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  Player player = Player();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(children: [
                  ...fisrtBlock(),
                  _expanded(context),
                  ...lastBlock(),
                ])
              : Row(children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...fisrtBlock(),
                          ...lastBlock(),
                        ]),
                  ),
                  _expanded(context),
                ]),
        ));
  }

  List<Widget> fisrtBlock() {
    return [
      SwitchListTile.adaptive(
          title: const Text("Turn on/off Two Players",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          value: isSwitched,
          onChanged: (val) {
            setState(() {
              isSwitched = val;
            });
          }),
      Text("it's $activePlayer turn",
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    ];
  }

  List<Widget> lastBlock() {
    return [
      Text(result, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ElevatedButton.icon(
          onPressed: () {
            setState(() {
              activePlayer = 'x';
              isFinished = false;
              turn = 0;
              result = '';
              Player.playersX = [];
              Player.playersO = [];
            });
          },
          icon: const Icon(Icons.replay),
          label: const Text("Repeat the game",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).splashColor)))
    ];
  }

  onTap(int index) async {
    if ((Player.playersX.isEmpty || !Player.playersX.contains(index)) &&
        (Player.playersO.isEmpty || !Player.playersO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();
      if (!isSwitched && !isFinished && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == 'x' ? 'o' : 'x';
      turn++;
      String winnerResult = game.checkWinners();
      if (winnerResult != '') {
        isFinished = true;
        result = "$winnerResult is winner";
      } else if (!isFinished && turn == 9) {
        result = "no winner";
      }
    });
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
        child: GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 1.0,
      children: List.generate(
          9,
          (index) => InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: isFinished ? null : () => onTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    Player.playersX.contains(index)
                        ? 'x'
                        : Player.playersO.contains(index)
                            ? 'o'
                            : "",
                    style: TextStyle(
                        color: Player.playersX.contains(index)
                            ? Colors.blueAccent
                            : Colors.pinkAccent,
                        fontSize: 60),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
    ));
  }
}
