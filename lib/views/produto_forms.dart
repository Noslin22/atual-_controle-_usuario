import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/produto.dart';
import 'package:atual_controle_usuario/provider/produtos.dart';
import 'package:provider/provider.dart';

class ProdutoForm extends StatefulWidget {
  @override
  _ProdutoFormState createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _pform = GlobalKey<FormState>();

  final Map<String, String> _pformData = {};

  void _loadFormData(Produto produto) {
    if (produto != null) {
      _pformData['id'] = produto.id;
      _pformData['nome'] = produto.nome;
      _pformData['quantidade'] = produto.quantidade;
      _pformData['valor'] = produto.valor;
      _pformData['descricao'] = produto.descricao;
      _pformData['avatarUrl'] = produto.avatarUrls;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Produto produto = ModalRoute.of(context).settings.arguments;
    _loadFormData(produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _pform.currentState.validate();

              if (isValid) {
                _pform.currentState.save();

                Provider.of<Produtos>(context, listen: false).put(
                  Produto(
                    id: _pformData['id'],
                    nome: _pformData['nome'],
                    quantidade: _pformData['quantidade'],
                    valor: _pformData['valor'],
                    descricao: _pformData['descricao'],
                    avatarUrls: _pformData['avatarUrl'],
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _pform,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _pformData['nome'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome inválido';
                  }

                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }

                  return null;
                },
                onSaved: (value) => _pformData['nome'] = value,
              ),
              TextFormField(
                initialValue: _pformData['quantidade'],
                decoration: InputDecoration(labelText: 'Quantidade'),
                onSaved: (value) => _pformData['quantidade'] = value,
              ),
              TextFormField(
                initialValue: _pformData['valor'],
                decoration: InputDecoration(labelText: 'valor'),
                onSaved: (value) => _pformData['valor'] = value,
              ),
              TextFormField(
                initialValue: _pformData['descricao'],
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _pformData['descricao'] = value,
              ),
              TextFormField(
                initialValue: _pformData['avatarUrls'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _pformData['avatarUrls'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
