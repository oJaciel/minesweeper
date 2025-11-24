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
  Board _board = Board(lines: 12, columns: 12, bombQuantity: 3);

  _restart() {
    setState(() {
      _winned = null;
      _board.restart();
    });
  }

  _open(Field field) {
    if (_winned != null) {
      return;
    }
    setState(() {
      try {
        field.open();
        if (_board.resolved) {
          _winned = true;
        }
      } on ExplosionException {
        _winned = false;
        _board.revealBombs();
      }
    });
  }

  _toggleMark(Field field) {
    if (_winned != null) {
      return;
    }
    setState(() {
      field.toggleMark();
      if (_board.resolved) {
        _winned = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultWidget(winned: _winned, onRestart: _restart),
      body: BoardWidget(
        board: _board,
        onOpen: _open,
        onToggleMark: _toggleMark,
      ),
    );
  }
}
