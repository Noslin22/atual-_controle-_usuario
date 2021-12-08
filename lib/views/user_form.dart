import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/models/user.dart';
import 'package:atual_controle_usuario/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  User editUser;
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['password'] = user.password;
      _formData['cargo'] = user.cargo;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    editUser = ModalRoute.of(context).settings.arguments;
    _loadFormData(editUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();

              if (isValid) {
                _form.currentState.save();
                User user = User(
                  id: _formData['id'],
                  name: _formData['name'],
                  email: _formData['email'],
                  password: _formData['password'],
                  cargo: _formData['cargo'],
                  avatarUrl: _formData['avatarUrl'],
                );
                if (editUser == null) {
                  Provider.of<Users>(context, listen: false).put(user);

                  FirebaseFirestore db = FirebaseFirestore.instance;
                  db.collection("users").add(user.toMap());
                } else {
                  FirebaseFirestore db = FirebaseFirestore.instance;
                  db
                      .collection("users")
                      .where("name", isEqualTo: editUser.name)
                      .get()
                      .then(
                        (value) => value.docs.single.reference.update(
                          user.toMap(),
                        ),
                      );
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
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
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['password'],
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (value) => _formData['password'] = value,
              ),
              TextFormField(
                initialValue: _formData['cargo'],
                decoration: InputDecoration(labelText: 'Cargo'),
                onSaved: (value) => _formData['cargo'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
