import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/bricks.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/gameoverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomepageState extends State<HomePage> {
  //ball
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.01;
  double ballYincrements = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //jugador
  double playerX = -0.2;
  double playerWidth = 0.4;

  //ladrillos
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBrickInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBrickInRow * brickWidth -
          (numberOfBrickInRow - 1) * brickGap);

  // bool brickBroken = false;

  List MyBricks = [
    // [x, y, broken = true/false]
    //[firstBrickX, firstBrickY, false],
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false]
  ];

  //ajusted del juego
  bool hasGameStarted = false;
  bool isGameOver = false;

  void startGame() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // Actualizar dirección
      updateDirection();

      // movimiento de la pelota
      moveBall();

      //Revisar si jugador muere
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      //Revisar si el ladrillo es golpeado
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    //Revisa cuando golpea el ladrillo de abajo
    for (int i = 0; i < MyBricks.length; i++) {
      if (ballX >= MyBricks[i][0] &&
          ballX <= MyBricks[i][0] + brickWidth &&
          ballY <= MyBricks[i][1] + brickHeight &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;


          ballYDirection = direction.DOWN;

          ballYDirection = direction.UP;

          ballYDirection = direction.LEFT;

          ballYDirection = direction.RIGHT;
        });
      }
    }
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }

    return false;
  }

  void moveBall() {
    setState(() {
      //MOVER HORIZONTALMENTE
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrements;
      }

      //MOVER HORIZONTALMENTE
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrements;
      }
    });
  }
  /* void moveBall() {
    setState(() {
      // Mover horizontalmente
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrements;
      }

      // Mover verticalmente
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrements;
      }
    });
  } */

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: Center(
              child: Stack(
                children: [
                  // presionar para jugar
                  CoverScreen(hasGameStarted: hasGameStarted),

                  //Game Over
                  GameOverScreen(isGameOver: isGameOver),

                  //ball
                  MyBall(
                    ballX: ballX,
                    ballY: ballY,
                  ),

                  //Jugador
                  MyPlayer(
                    playerX: playerX,
                    playerWidth: playerWidth,
                  ),

                  //Ladrillos
                  MyBrick(
                    brickX: MyBricks[0][0],
                    brickY: MyBricks[0][1],
                    brickBroken: MyBricks[0][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                    
                  ),
                  MyBrick(
                    brickX: MyBricks[1][0],
                    brickY: MyBricks[1][1],
                    brickBroken: MyBricks[1][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                  ),
                  MyBrick(
                    brickX: MyBricks[2][0],
                    brickY: MyBricks[2][1],
                    brickBroken: MyBricks[2][2],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                  ),

                  //Ubicación del jugador
                  /* Container(
                    alignment: Alignment(playerX, 0.9),
                    child: Container(
                      color: Colors.red,
                      width: 4,
                      height: 15,
                    ),
                  ),
                  Container(
                    alignment: Alignment(playerX + playerWidth, 0.9),
                    child: Container(
                      color: Colors.green,
                      width: 4,
                      height: 15,
                    ),
                  ), */
                ],
              ),
            )),
      ),
    );
  }
}
