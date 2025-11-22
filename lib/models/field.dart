import 'explosion_exception.dart';

class Field {
  Field({required this.line, required this.column});

  //Linha e coluna que está o campo
  final int line;
  final int column;

  //Lista de campos ao redor desse
  final List<Field> neighbors = [];

  //Booleanos para controle do jogo
  bool _opened = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  //Adiciona vizinho ao campo
  void addNeighbor(Field neighbor) {
    //Primeiro verifica o delta da linha e coluna do campo com o outro
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    //Se o resultado for 0 em ambos, é porque o campo selecionado é o mesmo que está sendo comparado
    //Somente ignora
    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    //Se a diferença de ambos for somente 1, é porque o campo selecionado está do lado do atual
    if (deltaLine <= 1 && deltaColumn <= 1) {
      //Adiciona campo a lista de vizinhos
      neighbors.add(neighbor);
    }
  }

  //Abrir um campo
  void open() {
    //Se já está aberto, não faz nada
    if (_opened) return;

    _opened = true;

    //Se o campo aberto está minado, perde
    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    //Se ele for aberto, e a vizinhança não estiver minada, segue abrindo outros campos
    if (secureNeighborhood) {
      neighbors.forEach((v) => v.open());
    }
  }

  //Fim do jogo
  //Se o campo estiver minado, abre ele
  void revealBomb() {
    if (_mined) _opened = true;
  }

  //Settando um campo como minado
  void mineField() {
    _mined = true;
  }

  //Alternando a marcação do campo
  void toggleMark() {
    _marked = !_marked;
  }

  //Reinicia o jogo
  void restart() {
    _opened = false;
    _marked = false;
    _mined = false;
    _exploded = false;
  }

  //Getters dos parâmetros
  bool get mined {
    return _mined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }

  bool get resolved {
    bool minedAndMarked = mined && marked;
    bool secureAndOpened = !mined && opened;
    return minedAndMarked || secureAndOpened;
  }

  bool get secureNeighborhood {
    return neighbors.every((n) => n.mined == false);
  }

  int get neighborhoodMineQuantity {
    return neighbors.where((n) => n.mined).length;
  }
}
