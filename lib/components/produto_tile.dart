import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/produto.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';

class ProdutoTile extends StatelessWidget {
  final Produto produto;

  const ProdutoTile(this.produto);

  @override
  Widget build(BuildContext context) {
    final avatar = produto.avatarUrls == null || produto.avatarUrls.isEmpty
        ? CircleAvatar(child: Icon(Icons.store))
        : CircleAvatar(backgroundImage: NetworkImage(produto.avatarUrls));
    return ListTile(
      leading: avatar,
      title: Text(produto.nome),
      subtitle: Text(produto.status),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUTO_FORM,
                  arguments: produto,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Tem certeza disto?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confimed) {
                  if (confimed) {
                        FirebaseFirestore db = FirebaseFirestore.instance;
                    db
                        .collection("produtos")
                        .where("nome", isEqualTo: produto.nome)
                        .get()
                        .then(
                          (value) => value.docs.single.reference.delete(),
                        );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
