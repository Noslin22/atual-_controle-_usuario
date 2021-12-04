import 'package:flutter/material.dart';

class Estoque extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EstoqueState();
  }
}

class EstoqueState extends State<Estoque> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: SizedBox(child: Text('APP')))),
      body: Center(
        child: Text(
          'teste',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.red, fontSize: 50.0),
        ),
      ),
    );
  }
}
