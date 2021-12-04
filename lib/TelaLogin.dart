import 'package:atual_controle_usuario/views/user_list.dart';
import 'package:flutter/material.dart';

class LoginTela extends StatefulWidget {
  const LoginTela({key}) : super(key: key);

  @override
  _LoginTelaState createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  String login = '';
  String senha = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: SizedBox(child: Text('Login')))),
      body: Material(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
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
                  decoration: InputDecoration(
                      labelText: 'Login:', border: OutlineInputBorder()),
                ),
                SizedBox(height: 15),
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha:', border: OutlineInputBorder()),
                ),
                SizedBox(height: 15),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    if (login == 'david' && senha == '123456') {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => UserList()));
                    } else {
                      AlertDialog(content: Text('Login ou senha invalido'));
                    }
                  },
                  child: Text('Entrar'),
                ),
                Container(
                  width: 200,
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  text(String s) {}
}
