import 'package:atual_controle_usuario/TelaLogin.dart';
import 'package:atual_controle_usuario/views/estoque.dart';
import 'package:atual_controle_usuario/views/user_form.dart';
import 'package:atual_controle_usuario/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/provider/users.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'TelaLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Atual - Controle de Estoque',
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
        },
      ),
    );
  }
}
