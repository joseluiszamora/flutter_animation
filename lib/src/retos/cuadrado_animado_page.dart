import 'package:flutter/material.dart';

class CuadradoAnimadoPage extends StatelessWidget {
  const CuadradoAnimadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _CuadradoAnimado()),
    );
  }
}

class _CuadradoAnimado extends StatefulWidget {
  const _CuadradoAnimado();

  @override
  State<_CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<_CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> moverRight;
  late Animation<double> moverTop;
  late Animation<double> moverLeft;
  late Animation<double> moverBottom;

//curvebounceout
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    moverRight = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 0.25, curve: Curves.bounceOut)),
    );

    moverTop = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0.25, 0.50, curve: Curves.bounceOut)),
    );

    moverLeft = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0.50, 0.75, curve: Curves.bounceOut)),
    );

    moverBottom = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
          parent: controller,
          curve: const Interval(0.75, 1.0, curve: Curves.bounceOut)),
    );

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(moverRight.value + moverLeft.value,
              -moverTop.value - moverBottom.value),
          child: const _Rectangulo(),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  const _Rectangulo();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(color: Colors.blue));
  }
}
