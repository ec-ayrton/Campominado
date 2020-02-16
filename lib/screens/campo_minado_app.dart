import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;
  Tabuleiro _tabuleiro;

  void _reinicar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    setState(() {
      if (_venceu != null) {
        return;
      }
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura){
    if(_tabuleiro == null){
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdelinhas = (altura / tamanhoCampo).floor(); 

      _tabuleiro = Tabuleiro(
        linhas: qtdelinhas, 
        colunas: qtdeColunas, 
        qtdeBombas: 50,
      );
      return _tabuleiro;
    }
    return _tabuleiro;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reinicar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints){
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(constraints.maxWidth, constraints.maxHeight), 
                onAbrir: _abrir, 
                onAlternarMarcacao: _alternarMarcacao,
                );
            },
          ),
        ),
      ),
    );
  }
}
