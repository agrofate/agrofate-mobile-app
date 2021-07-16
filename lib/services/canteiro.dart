import 'package:flutter/material.dart';

class Canteiro {
  String nomeCanteiro;
  Image? imagem;
  String dataCriacao;
  String dataUltimaAtualizacao;

  Canteiro({
    required this.nomeCanteiro,
    this.imagem,
    required this.dataCriacao,
    required this.dataUltimaAtualizacao,
  });

// TODO: função async para recuperar do banco as infos
}
