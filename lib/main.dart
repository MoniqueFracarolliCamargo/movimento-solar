import 'package:flutter/material.dart';
import 'package:movimento_solar/controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movimento Solar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black12,
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: const [
            MyHomePage(
              duracao: Duration(seconds: 6),
              corInicial: Color(0xff0c1445),
              corFinal: Color(0xff76d7ea),
            ),
            MyHomePage(
                duracao: Duration(seconds: 1),
                numeroObjetos: 88,
                cor: Colors.white),
            MyHomePage(
                duracao: Duration(seconds: 1),
                alturaObjeto: 128,
                numeroObjetos: 6,
                cor: Color(0xffcccccc)),
            MyHomePage(
                duracao: Duration(seconds: 1),
                alturaObjeto: 86,
                numeroObjetos: 8),
            MyHomePage(
                duracao: Duration(seconds: 1),
                corInicial: Color(0xffe65100),
                corFinal: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
