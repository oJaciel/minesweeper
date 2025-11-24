import 'package:flutter/material.dart';
import 'package:minesweeper/components/result_widget.dart';

class Minesweeper extends StatelessWidget {
  const Minesweeper({super.key});

  _restart() {
    print('Reiniciar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultWidget(winned: true, onRestart: _restart),
      body: Container(child: Text('Tabuleiro')),
    );
  }
}
