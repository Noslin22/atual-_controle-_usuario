import 'package:atual_controle_usuario/data/dummy_produtos.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/produto.dart';
import 'dart:math';

class Produtos with ChangeNotifier {
  final Map<String, Produto> _produtos = {...DUMMY_PRODUTOS};

  List<Produto> get all {
    return [..._produtos.values];
  }

  int get count {
    return _produtos.length;
  }

  Produto byIndex(int i) {
    return _produtos.values.elementAt(i);
  }

  void put(Produto produto) {
    if (produto == null) {
      return;
    }

    if (produto.id != null &&
        produto.id.trim().isNotEmpty &&
        _produtos.containsKey(produto.id)) {
      _produtos.update(
        produto.id,
        (_) => Produto(
          id: produto.id,
          nome: produto.nome,
          quantidade: produto.quantidade,
          valor: produto.valor,
          descricao: produto.descricao,
          status: produto.status,
          avatarUrls: produto.avatarUrls,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      _produtos.putIfAbsent(
        id,
        () => Produto(
          id: id,
          nome: produto.nome,
          quantidade: produto.quantidade,
          valor: produto.valor,
          descricao: produto.descricao,
          status: produto.status,
          avatarUrls: produto.avatarUrls,
        ),
      );
    }
    notifyListeners();
  }

  void remove(Produto produto) {
    if (produto != null && produto.id != null) {
      _produtos.remove(produto.id);
      notifyListeners();
    }
  }
}
