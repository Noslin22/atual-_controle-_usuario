import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/user.dart';
import 'package:atual_controle_usuario/Provider/users.dart';
import 'package:atual_controle_usuario/Routes/app_Routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    var avatar;

    /* Recuperando a imagem do avatar do usuário..*/
    if (user.avatarUrl == null || user.avatarUrl.isEmpty)
      avatar = CircleAvatar(child: Icon(Icons.person));
    else
      avatar = CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    /* Criando e retornando o ListTile para o ListView..*/
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            // Editar usuario..
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                }),

            // Remover usuario..
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Apagar usuário"),
                      content: Text('Confirmar exclusão?'),
                      actions: <Widget>[
                        const SizedBox(height: 30),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Cancelar'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),

                          child: const Text('Confirmar'),
                          onPressed: () => Navigator.of(context).pop(
                              true), // Confirma exclusao e retorna para a FUTURE (== promise)
                        ),
                      ],
                    ),
                  ).then((confirmado) {
                    // Realiza a promise se o NAVIGATOR retornou TRUE..
                    if (confirmado) {
                      Provider.of<Users>(context, listen: false)
                          .remove(user); // Exclui o usuario
                    }
                  });
                }),
          ],
        ),
      ),
    );
  }
}
