import 'package:flutter/material.dart';

class FloorPlanPainter extends CustomPainter {
  final int floorNumber;
  final Color backgroundColor;
  final Color lineColor;

  FloorPlanPainter({
    required this.floorNumber,
    this.backgroundColor = Colors.white,
    this.lineColor = Colors.black54,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Offset.zero & size, paint);

    // Draw grid lines
    paint.color = lineColor.withOpacity(0.2);
    paint.strokeWidth = 1.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw some random rooms
    paint.color = lineColor;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    // Draw different layouts for each floor
    switch (floorNumber) {
      case 0:
        _drawGroundFloor(canvas, size, paint);
        break;
      case 1:
        _drawFirstFloor(canvas, size, paint);
        break;
      case 2:
        _drawSecondFloor(canvas, size, paint);
        break;
    }
  }

  void _drawGroundFloor(Canvas canvas, Size size, Paint paint) {
    // Draw main hall
    canvas.drawRect(
      Rect.fromLTWH(50, 50, size.width - 100, 100),
      paint,
    );

    // Draw rooms
    canvas.drawRect(
      Rect.fromLTWH(50, 200, 100, 80),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(200, 200, 100, 80),
      paint,
    );
  }

  void _drawFirstFloor(Canvas canvas, Size size, Paint paint) {
    // Draw corridor
    canvas.drawRect(
      Rect.fromLTWH(size.width / 4, 50, size.width / 2, size.height - 100),
      paint,
    );

    // Draw rooms on sides
    for (int i = 0; i < 3; i++) {
      canvas.drawRect(
        Rect.fromLTWH(20, 50 + (i * 120), 100, 80),
        paint,
      );
      canvas.drawRect(
        Rect.fromLTWH(size.width - 120, 50 + (i * 120), 100, 80),
        paint,
      );
    }
  }

  void _drawSecondFloor(Canvas canvas, Size size, Paint paint) {
    // Draw central area
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      100,
      paint,
    );

    // Draw connecting corridors
    paint.strokeWidth = 4.0;
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(50, 50),
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width - 50, 50),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 