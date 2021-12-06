import 'package:flutter/material.dart';

class Produto {
  final String id;
  final String nome;
  final String quantidade;
  final String valor;
  final String descricao;
  final String avatarUrls;

  const Produto({
    this.id,
    @required this.nome,
    @required this.quantidade,
    @required this.valor,
    @required this.descricao,
    this.avatarUrls,
  });
}