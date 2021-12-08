import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/components/user_tile.dart';
//import 'package:atual_controle_usuario/models/user.dart';
import 'package:atual_controle_usuario/provider/users.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

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
                leading: Icon(Icons.store),
                title: Text('Estoque'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/estoque');
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
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
