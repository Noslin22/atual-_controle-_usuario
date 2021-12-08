import 'package:atual_controle_usuario/TelaLogin.dart';
import 'package:atual_controle_usuario/provider/produtos.dart';
import 'package:atual_controle_usuario/views/estoque.dart';
import 'package:atual_controle_usuario/views/produto_forms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/provider/users.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';
import 'package:atual_controle_usuario/views/user_form.dart';
import 'package:atual_controle_usuario/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(LoginTela));
}

class MyApp extends StatelessWidget {
  MyApp(Type loginTela);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Produtos(),
        ),
      ],
      child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Material(
                child: Center(
                  child: Text(
                    "Ocorreu um erro, tente novamente mais tarde.\n${snapshot.error.toString()}",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Atual APP',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                initialRoute: '/',
                routes: {
                  AppRoutes.HOME: (_) => LoginTela(),
                  AppRoutes.USER_FORM: (_) => UserForm(),
                  AppRoutes.ESTOQUE: (_) => Estoque(),
                  AppRoutes.USER: (_) => UserList(),
                  AppRoutes.PRODUTO_FORM: (_) => ProdutoForm(),
                },
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
