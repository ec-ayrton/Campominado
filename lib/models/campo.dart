import 'package:campo_minado/models/explosao_exception.dart';
import 'package:flutter/foundation.dart';

class Campo{
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;  

  Campo({
    @required this.linha,
    @required this.coluna,
  });

  void adicionarVizinho(Campo vizinho){
    final deltaLinha = (linha - vizinho.linha).abs();// modulo, sempre positivo.
    final deltaColuna = (coluna - vizinho.coluna).abs();// modulo, sempre positivo.

    if(deltaLinha == 0 && deltaColuna == 0){
      return;
    }

    if(deltaLinha <= 1 && deltaColuna <=1){
      vizinhos.add(vizinho);
    }
  }
  
  void abrir(){
    if(_aberto){
      return;
    }

    _aberto = true;

    if(_minado){
      _explodido = true;
      throw ExplosaoException();
    }

    if(vizinhancaSegura){
      vizinhos.forEach( (v) => v.abrir() );
    }

  }

  void revelarBomba(){
    if(_minado){
      _aberto = true;
    }
  }

  void minar(){
    _minado = true;
  }

  void alternarMarcacao(){
    _marcado = !_marcado;
  }

  void reiniciar(){
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;     
  }

  bool get minado{
    return _minado;
  }

    bool get aberto{
    return _aberto;
  }

  bool get explodido{
    return _explodido;
  }

  bool get marcado{
    return _marcado;
  }

  bool get resolvido{
    bool minadoEmarcado = _minado && _marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEmarcado || seguroEAberto;
  }

  bool get vizinhancaSegura{
    return vizinhos.every( (v) => !v._minado) ;
  }

  int get qtdeMinasnaVizinhanca{
    return vizinhos.where((v)=> v.minado).length;
  }

}



  



