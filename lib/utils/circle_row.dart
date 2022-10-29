import 'dart:math';

import 'package:flutter/material.dart';

class CurvedRow extends StatelessWidget {
  final Widget child;
  final int numStatus;
  const CurvedRow({
    Key? key,
    required this.child,
    this.numStatus = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvedPaint(
        numStatus: numStatus,
      ),
      child: Container(
        margin: const EdgeInsets.all(
          4.0,
        ),
        child: child,
      ),
    );
  }
}

class CurvedPaint extends CustomPainter {
  final int numStatus;

  const CurvedPaint({required this.numStatus});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..color = Colors.deepOrangeAccent
      ..style = PaintingStyle.stroke;

    drawArc(canvas, size, paint);
  }

  ///Convert degrees to angle in radians
  degreeToAngleRadian(double degree) {
    return degree * pi / 180;
  }

  ///Draw the stroke on a canvas
  void drawArc(Canvas canvas, Size size, Paint paint) {
    ///if its only one status return a complete circle
    if (numStatus == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngleRadian(0),
        degreeToAngleRadian(360),
        false,
        paint,
      );
    } else {
      double degree = -90;
      double arc = 360 / numStatus;
      for (int i = 0; i < numStatus; i++) {
        canvas.drawArc(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngleRadian(degree + 4),
          degreeToAngleRadian(arc - 8),
          false,
          paint,
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
