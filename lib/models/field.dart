import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  Field({required this.line, required this.column});

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_open) return;

    _open = true;

    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (secureNeighborhood) {
      neighbors.forEach((v) => v.open());
    }
  }

  bool get mined {
    return _mined;
  }

  bool get secureNeighborhood {
    return neighbors.every((n) => n.mined == false);
  }
}
