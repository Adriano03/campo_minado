import 'package:campo_minado/models/explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  //                Vizinho
  final List<Campo> vizinhos = [];
  // Campo aberto ou fechado;
  bool _aberto = false;
  // Campo marcado;
  bool _marcado = false;
  // Campo que está minado(com bomba);
  bool _minado = false;
  // Especifica qual campo que foi explodido;
  bool _explodido = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    // Se for igual zero é o proprio vizinho;
    if (deltaLinha == 00 && deltaColuna == 0) {
      return;
    }

    // Se a diferença entre as linhas for <= 1 significa que existe vizinho;
    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    // Se o campo já tiver aberto apenas retorna;
    if (_aberto) {
      return;
    }

    _aberto = true;
    // Se campo contém bomba, _exploded recebe true;
    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      for (var v in vizinhos) {
        v.abrir();
      }
    }
  }

  // Depois que perder, abrir todos os campos com bomba;
  void revealBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  // Alterar marcação (Click longo);
  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  // Reiniciar jogo;
  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  // Se todos os campos -> true, pra esse metódo o user ganhou o jogo;
  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  // Metódo vizinhaça segura;
  bool get vizinhancaSegura {
    // Todos os vizinhos não podem está com bomba;
    return vizinhos.every((v) => !v.minado);
  }

  // Quantidade de minas em volta no click;
  int get qtdeMinasNaVizinhaca {
    return vizinhos.where((v) => v.minado).length;
  }
}
