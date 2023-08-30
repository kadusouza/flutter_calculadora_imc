import 'package:flutter/material.dart';

class LinearGauge extends StatelessWidget {
  final double value;

  const LinearGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: CustomPaint(
        painter: GaugePainter(value: value),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double value;

  GaugePainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;

    // Draw gradient segments
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.red
        ],
      ).createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(width, size.height)));

    canvas.drawRect(
        Rect.fromPoints(const Offset(0, 0), Offset(width, size.height)), paint);

    // Draw marker for dynamic value
    Paint markerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0; // Increase the thickness of the marker line

    double markerPosition =
        (value / 40) * width; // 40 is the max value of the gauge
    canvas.drawLine(Offset(markerPosition, 0),
        Offset(markerPosition, size.height), markerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
