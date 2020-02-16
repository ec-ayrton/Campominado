import 'dart:math';

import 'campo.dart';
import 'package:flutter/foundation.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sorterMinas();
  }

  void reiniciar(){
    _campos.forEach((c) => c.reiniciar());
    _sorterMinas();
  }

  void revelarBombas(){
    _campos.forEach((c)=> c.revelarBomba());
  }

  void _criarCampos() {
    for (var l = 0; l < linhas; l++) {
      for (var c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sorterMinas() {
    int sorteadas = 0;
    
    if(qtdeBombas > linhas * colunas){
      return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos{
    return _campos;
  }

  bool get resolvido{
    return _campos.every((c)=> c.resolvido);
  }  

}
