import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/sakura.dart';

class SakuraFalling extends StatefulWidget {
  @override
  _SakuraFallingState createState() => _SakuraFallingState();
}

class _SakuraFallingState extends State<SakuraFalling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Sakura> _sakuras = [];

  @override
  void initState() {
    super.initState();
    _initSakuras();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 30))
          ..repeat();
  }

  void _initSakuras() {
    _sakuras = List.generate(100, (index) {
      final x = math.Random().nextDouble();
      final y = math.Random().nextDouble() * -2.0; // 初期位置を画面上方に設定
      final size = math.Random().nextDouble() * 2 + 5; // 花びらのサイズを大きくする
      final speed = math.Random().nextDouble() * 0.005 + 0.002; // 落下速度を遅くする
      return Sakura(x: x, y: y, size: size, speed: speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return CustomPaint(
          painter: SakuraPainter(_sakuras, _controller.value),
          child: Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SakuraPainter extends CustomPainter {
  final List<Sakura> sakuras;
  final double progress;

  SakuraPainter(this.sakuras, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pink;
    sakuras.forEach((sakura) {
      final xPosition = sakura.x * size.width;
      final yPosition =
          ((sakura.y + progress * sakura.speed) % 2.0) * size.height;
      canvas.drawCircle(Offset(xPosition, yPosition), sakura.size, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
