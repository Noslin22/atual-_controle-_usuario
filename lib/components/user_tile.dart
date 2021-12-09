import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/user.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';

import '../globals.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                db.collection("users").doc(idUser).get().then((value) {
                //Vejo se o usuario logado é o mesmo que tá tentando deletar
                  if (value.data()["email"] != user.email) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Excluir Usuário'),
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
                            .collection("users")
                            .where("name", isEqualTo: user.name)
                            .get()
                            .then(
                              (value) => value.docs.single.reference.delete(),
                            );
                      }
                    });
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
