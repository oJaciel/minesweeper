import 'dart:math';

import 'package:minesweeper/models/field.dart';

class Board {
  final int lines;
  final int columns;
  final int bombQuantity;

  final List<Field> _fields = [];

  Board({
    required this.lines,
    required this.columns,
    required this.bombQuantity,
  }) {
    _createFields();
    _relateNeighbors();
    _sortMines();
  }

  //Reinicia o jogo
  void restart() {
    _fields.forEach((f) => f.restart());
    _sortMines();
  }

  //Revela todas as bombas do jogo
  void revealBombs() {
    _fields.forEach((f) => f.revealBomb());
  }

  //Cria os campos do jogo
  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  //Relaciona os vizinhos dos campos
  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  //Sorteia as minas
  void _sortMines() {
    int sorted = 0;

    if (bombQuantity > lines * columns) {
      return;
    }

    while (sorted < bombQuantity) {
      int i = Random().nextInt(_fields.length);

      if (_fields[i].mined == false) {
        sorted++;
        _fields[i].mineField();
      }
    }
  }

  //Getters dos parâmetros
  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((f) => f.resolved);
  }
}
