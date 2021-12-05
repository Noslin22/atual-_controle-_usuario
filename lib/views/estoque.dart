import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/provider/produtos.dart';
import 'package:atual_controle_usuario/components/produto_tile.dart';
import 'package:provider/provider.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';

class Estoque extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Produtos produtos = Provider.of(context);
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
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUTO_FORM);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: produtos.count,
        itemBuilder: (ctx, i) => ProdutoTile(produtos.byIndex(i)),
      ),
    );
  }
}
