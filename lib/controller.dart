import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final int? alturaObjeto;
  final int? numeroObjetos;
  final Color? cor;
  final Duration duracao;
  final Color? corInicial;
  final Color? corFinal;
  const MyHomePage({
    this.alturaObjeto,
    this.numeroObjetos,
    this.cor,
    required this.duracao,
    this.corInicial,
    this.corFinal,
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late final Duration duracao;
  final random = Random();
  final List<Map<String, double>> coordenadas = [];
  bool visivel = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: duracao,
    );
    animationController.addListener(
      () {
        setState(() {
          if (animationController.value > 0.5 && !visivel) {
            visivel = true;
            animationController.reset();
            animationController.forward();
          }
        });
      },
    );
    animationController.addStatusListener((status) {
      // para os pássaros ficarem rodando
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      }
    });
    super.initState();

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passo = 1 / widget.numeroObjetos!;
    return Scaffold(
        body: Stack(
      children: [
        for (final coord in coordenadas.getRange(
            0, widget.numeroObjetos! - animationController.value ~/ passo))
          Align(
            alignment: Alignment(
              coord['x']!,
              coord['y']!,
            ),
            child: Icon(
              Icons.star,
              size: 12,
              color: widget.cor,
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(color: _cor),
          child: const Center(),
        ),
        for (int i = 0; i < coordenadas.length; i++)
          () {
            final coord = coordenadas[i];
            double posX = 1 - 2 * animationController.value - coord['dx']!;
            posX += (posX <= -1) ? 2 : 0;
            return Visibility(
              visible: visivel,
              child: Opacity(
                opacity: .7,
                child: Align(
                  alignment: Alignment(
                    posX,
                    coord['y']!,
                  ),
                  child: Icon(
                    Icons.cloud_rounded,
                    size: widget.alturaObjeto!.toDouble(),
                    color: widget.cor,
                    shadows: [
                      BoxShadow(
                          blurRadius: 12, spreadRadius: 32, color: widget.cor!)
                    ],
                  ),
                ),
              ),
            );
          }(),
        for (int i = 0; i < coordenadas.length; i++)
          () {
            final coord = coordenadas[i];
            double posX = -1 + 2 * animationController.value - coord['dx']!;
            posX -= (posX >= 1) ? 2 : 0;
            return Visibility(
              visible: visivel,
              child: Align(
                alignment: Alignment(
                  posX, // indo da esquerda para a direita
                  coord['y']!,
                ),
                child: Image(
                  height: widget.alturaObjeto!.toDouble(),
                  image: const AssetImage('assets/passaro-branco.gif'),
                  color: widget.cor,
                ),
              ),
            );
          }(),
        Align(
          alignment: Alignment(
            .65,
            .75 - 1.5 * animationController.value,
          ),
          child: _sol1(_cor),
        )
      ],
    ));
  }

  Color get _cor => Color.lerp(
        widget.corInicial,
        widget.corFinal,
        animationController.value,
      )!;
  Widget _sol1(final Color color) => DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _cor,
              blurRadius: 24,
              spreadRadius: 84,
            ),
          ],
        ),
      );
}
