import 'package:atual_controle_usuario/TelaInicial.dart';
import 'package:atual_controle_usuario/views/user_form.dart';
import 'package:flutter/material.dart';
import 'package:atual_controle_usuario/provider/users.dart';
import 'package:atual_controle_usuario/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        routes: {
          AppRoutes.HOME: (_) => TelaInicial(),
          AppRoutes.USER_FORM: (_) => UserForm()
        },
      ),
    );
  }
}
