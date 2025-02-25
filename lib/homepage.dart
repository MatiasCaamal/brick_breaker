import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/coverscreen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

enum direction { UP, DOWN }

class _HomepageState extends State<HomePage> {
  //ball
  double ballX = 0;
  double ballY = 0;
  var ballDirection = direction.DOWN;

  //jugador
  double playerX = 0;
  double playerWidth = 0.3;

  //ajusted del juego
  bool hasGameStarted = false;

  void startGame() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // Actualizar dirección
      updateDirection();

      // movimiento de la pelota
      moveBall();
    });
  }

  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9) {
        ballDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = direction.DOWN;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 <= -1)) {
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
