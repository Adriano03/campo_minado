import 'package:campo_minado/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';

class CampoMinadoApp extends StatefulWidget {
  final String qtdBombas;

  const CampoMinadoApp({
    super.key,
    required this.qtdBombas,
  });

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  void _reiniciarT() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    ));
  }

  void _abrir(Campo campo) {
    if (_venceu != null) return;
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) return;
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 14;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        qtdBombas: int.parse(widget.qtdBombas),
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultadoWidget(
        venceu: _venceu,
        onReiniciar: _reiniciar,
        reiniciarTotal: _reiniciarT,
      ),
      body: Container(
        color: Colors.grey.shade600,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return TabuleiroWidget(
              tabuleiro: _getTabuleiro(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              onAbrir: _abrir,
              onAlternarMarcacao: _alternarMarcacao,
            );
          },
        ),
      ),
    );
  }
}
