import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 28));

  GameOverScreen({required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  'G A M E  O V E R',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.deepPurple,
                      child: Text(
                        'J U E G A  D E  N U E V O',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}
