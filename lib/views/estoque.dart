import 'package:atual_controle_usuario/models/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/components/produto_tile.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';

import '../globals.dart';

class Estoque extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('David'),
              accountEmail: Text('David@atual.com'),
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
            ListTile(
                leading: Icon(Icons.people),
                title: Text('Usuários'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/user_list');
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Estoque'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUTO_FORM);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("produtos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro, tente novamente mais tarde.\n${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> produtos = snapshot.data.docs;
            return ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (ctx, i) {
                QueryDocumentSnapshot produto = produtos[i];
                return ProdutoTile(
                  Produto(
                    id: produto["id"],
                    nome: produto["nome"],
                    quantidade: produto["quantidade"],
                    valor: produto["valor"],
                    descricao: produto["descricao"],
                    status: produto["status"],
                    avatarUrls: produto["avatarUrls"],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
