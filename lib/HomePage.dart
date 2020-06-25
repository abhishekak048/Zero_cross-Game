import 'package:flutter/material.dart';
import 'package:fluttertictactoe/Game_button.dart';

import 'customDialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<GameButton> buttonList;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = doInit();
  }


  // ignore: missing_return
  List<GameButton> doInit(){
    player1 = new List();
    player2 = new List();
    activeplayer = 1;
    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),

    ];
    return gameButtons;
  }
  void playGame(GameButton gb){
    setState(() {
      if (activeplayer == 1){
        gb.text = "x";
        gb.bg = Colors.red;
        activeplayer =2;
        player1.add(gb.id);
      }
      else{
        gb.text = "0";
        gb.bg = Colors.black;
        activeplayer =1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      checkWinner();
    });
  }


  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 1 Won",
                "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 2 Won",
                "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
  }
  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("tic tok tic"),
      ),
        body: new GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            crossAxisSpacing: 9.0,
            mainAxisSpacing: 9,
          ),
          itemCount: buttonList.length,
          itemBuilder: (context,i)=> new SizedBox(
            width: 100,
              height: 100,
            child: new RaisedButton(
              padding: const EdgeInsets.all(10),
                onPressed: buttonList[i].enabled?()=>playGame(buttonList[i]):null,
              child: new Text(
                buttonList[i].text,
                style: new TextStyle(color: Colors.white,fontSize: 40),

              ),
              color: buttonList[i].bg,
              disabledColor: buttonList[i].bg,
            ),

          ),
        ),

    );
  }
}

