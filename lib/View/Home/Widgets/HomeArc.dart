import 'package:first_app/Constants/Constants.dart';
import 'package:flutter/material.dart';

class HomeArc extends StatelessWidget {
  HomeArc({
    required this.kCurveHeight,
    required this.kViewHeight,
    required this.contentWidget,
  });
  final double kCurveHeight;
  final double kViewHeight;
  final Widget contentWidget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
            painter: ShapesPainter(kCurveHeight: kCurveHeight),
            child: Container(height: kViewHeight)),
        Center(child: contentWidget),
      ],
    );
  }
}

class ShapesPainter extends CustomPainter {
  ShapesPainter({required this.kCurveHeight});
  final double kCurveHeight;
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2 * kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = kPrimaryColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
