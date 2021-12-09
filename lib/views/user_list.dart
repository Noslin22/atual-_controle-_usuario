import 'package:atual_controle_usuario/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/components/user_tile.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';
import '../globals.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot<Map>>(
                stream: db.collection("users").doc(idUser).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Ocorreu um erro, tente novamente mais tarde.\n${snapshot.error.toString()}",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data.data()["name"]),
                      accountEmail: Text(snapshot.data.data()["email"]),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro, tente novamente mais tarde.\n${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> users = snapshot.data.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, i) {
                QueryDocumentSnapshot user = users[i];
                return UserTile(
                  User(
                    name: user["name"],
                    email: user["email"],
                    password: user["password"],
                    cargo: user["cargo"],
                    avatarUrl: user["avatarUrl"],
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
