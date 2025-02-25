import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;

  CoverScreen({required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.1),
            child: Text(
              'Presiona para jugar',
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          );
  }
}
