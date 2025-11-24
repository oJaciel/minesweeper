import 'package:flutter/material.dart';
import 'package:minesweeper/components/board_widget.dart';
import 'package:minesweeper/components/result_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import 'package:minesweeper/models/field.dart';

class Minesweeper extends StatefulWidget {
  const Minesweeper({super.key});

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  bool? _winned;
  Board? _board;

  _restart() {
    setState(() {
      _winned = null;
      _board!.restart();
    });
  }

  _open(Field field) {
    if (_winned != null) {
      return;
    }
    setState(() {
      try {
        field.open();
        if (_board!.resolved) {
          _winned = true;
        }
      } on ExplosionException {
        _winned = false;
        _board!.revealBombs();
      }
    });
  }

  _toggleMark(Field field) {
    if (_winned != null) {
      return;
    }
    setState(() {
      field.toggleMark();
      if (_board!.resolved) {
        _winned = true;
      }
    });
  }

  Board getBoard(double width, double height) {
    if (_board == null) {
      int columnQuantity = 15;
      double fieldSize = width / columnQuantity;

      int lineQuantity = (height / fieldSize).floor();

      _board = Board(
        lines: lineQuantity,
        columns: columnQuantity,
        bombQuantity: (lineQuantity / 2).round(),
      );
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultWidget(winned: _winned, onRestart: _restart),
      body: Container(
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BoardWidget(
              board: getBoard(constraints.maxWidth, constraints.maxHeight),
              onOpen: _open,
              onToggleMark: _toggleMark,
            );
          },
        ),
      ),
    );
  }
}
