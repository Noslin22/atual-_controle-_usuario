import 'package:atual_controle_usuario/globals.dart';
import 'package:atual_controle_usuario/views/user_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginTela extends StatefulWidget {
  const LoginTela({key}) : super(key: key);

  @override
  _LoginTelaState createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String login = '';
  String senha = '';

  Widget _body() {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 700,
                height: 300,
                child: Image.asset("images/atual.png"),
              ),
              Container(
                height: 1,
              ),
              TextField(
                onChanged: (text) {
                  login = text;
                },
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Login:',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.7),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text) {
                  senha = text;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Senha:',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.7),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  db
                      .collection("users")
                      .where("email", isEqualTo: login)
                      .get()
                      .then((value) {
                    if (value.docs.isNotEmpty &&
                        value.docs.single.data()["password"] == senha) {
                      idUser = value.docs.single.id;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => UserList(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('LOGIN OU SENHA INVÁLIDO!'),
                        ),
                      );
                    }
                  });
                  // if (login == 'david' && senha == '123456') {
                  //   Navigator.of(context).pushReplacement(
                  //       MaterialPageRoute(builder: (context) => UserList()));
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (ctx) => AlertDialog(
                  //       title: Text('LOGIN OU SENHA INVÁLIDO!'),
                  //     ),
                  //   );
                  // }
                },
                color: Colors.blueGrey,
                child: Text('Entrar', style: TextStyle(color: Colors.white)),
              ),
              Container(
                width: 200,
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: SizedBox(child: Text('Login')))),
      body: _body(),
    );
  }

  text(String s) {}
}
