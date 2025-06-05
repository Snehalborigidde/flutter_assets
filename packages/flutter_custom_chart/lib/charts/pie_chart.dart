import 'package:flutter/material.dart';
import '../models/pie_chart_data.dart';
import 'dart:math';

class PieChart extends StatelessWidget {
  final List<PieChartData> data;

  const PieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PieChartPainter(data),
      size: Size.infinite,
    );
  }
}



class _PieChartPainter extends CustomPainter {
  final List<PieChartData> data;

  _PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    double startAngle = -pi / 2;
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple];

    for (int i = 0; i < data.length; i++) {
      final sweep = 2 * pi * (data[i].percentage / 100);
      paint.color = colors[i % colors.length];

      // Draw the slice
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        true,
        paint,
      );

      // Calculate label position (middle of the arc)
      final labelAngle = startAngle + sweep / 2;
      final labelRadius = radius * 0.6;
      final labelX = center.dx + labelRadius * cos(labelAngle);
      final labelY = center.dy + labelRadius * sin(labelAngle);

      final label = '${data[i].category} (${data[i].percentage.toStringAsFixed(0)}%)';
      final textSpan = TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Center the label on the point
      final offset = Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2);
      textPainter.paint(canvas, offset);

      // Move to the next slice
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
