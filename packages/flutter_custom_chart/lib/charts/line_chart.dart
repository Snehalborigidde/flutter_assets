import 'package:flutter/material.dart';
import '../models/line_chart_data.dart';

class LineChart extends StatelessWidget {
  final List<LineChartData> data;
  final Color lineColor;
  final double strokeWidth;

  const LineChart({
    super.key,
    required this.data,
    this.lineColor = Colors.blue,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(data, lineColor, strokeWidth),
      size: Size.infinite,
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<LineChartData> data;
  final Color color;
  final double strokeWidth;

  _LineChartPainter(this.data, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    const double paddingLeft = 40;
    const double paddingBottom = 30;
    const double paddingTop = 20;
    const double paddingRight = 20;

    final chartWidth = size.width - paddingLeft - paddingRight;
    final chartHeight = size.height - paddingBottom - paddingTop;

    final paintLine =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final paintPoint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

    final paintAxis =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1.5;

    final paintGrid =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 1;

    // Axes
    final origin = Offset(paddingLeft, size.height - paddingBottom);
    final xAxisEnd = Offset(
      size.width - paddingRight,
      size.height - paddingBottom,
    );
    final yAxisEnd = Offset(paddingLeft, paddingTop);

    canvas.drawLine(origin, xAxisEnd, paintAxis); // X axis
    canvas.drawLine(origin, yAxisEnd, paintAxis); // Y axis

    if (data.isEmpty) return;

    // Min/max values
    final maxX = data.map((e) => e.x).reduce((a, b) => a > b ? a : b);
    final maxY = data.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final minX = data.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    final minY = data.map((e) => e.y).reduce((a, b) => a < b ? a : b);

    final xRange = (maxX - minX) == 0 ? 1 : (maxX - minX);
    final yRange = (maxY - minY) == 0 ? 1 : (maxY - minY);

    final textPainter =
        (String text) => TextPainter(
          text: TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );

    void drawLabel(String text, Offset offset) {
      final tp = textPainter(text);
      tp.layout();
      tp.paint(canvas, offset);
    }

    // Draw horizontal Y grid lines & labels
    const int gridLines = 5;
    final yStep = chartHeight / gridLines;
    final yValueStep = yRange / gridLines;

    for (int i = 0; i <= gridLines; i++) {
      final y = paddingTop + i * yStep;
      final value = maxY - i * yValueStep;
      canvas.drawLine(
        Offset(paddingLeft, y),
        Offset(size.width - paddingRight, y),
        paintGrid,
      );
      drawLabel(value.toStringAsFixed(1), Offset(paddingLeft - 35, y - 6));
    }

    // Draw vertical X grid lines & labels
    final int xSteps = data.length;
    final xSpacing = chartWidth / (xSteps - 1);
    for (int i = 0; i < xSteps; i++) {
      final xVal = data[i].x;
      final x = paddingLeft + ((xVal - minX) / xRange) * chartWidth;
      canvas.drawLine(
        Offset(x, paddingTop),
        Offset(x, size.height - paddingBottom),
        paintGrid,
      );
      drawLabel(
        xVal.toStringAsFixed(1),
        Offset(x - 10, size.height - paddingBottom + 5),
      );
    }

    // Map data to canvas coordinates
    final points =
        data.map((point) {
          final dx = paddingLeft + ((point.x - minX) / xRange) * chartWidth;
          final dy =
              size.height -
              paddingBottom -
              ((point.y - minY) / yRange) * chartHeight;
          return Offset(dx, dy);
        }).toList();

    // Draw line path
    // final path = Path()..moveTo(points[0].dx, points[0].dy);
    // for (int i = 1; i < points.length; i++) {
    //   path.lineTo(points[i].dx, points[i].dy);
    // }
    // canvas.drawPath(path, paintLine);

    // Draw smooth curved line path
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final midPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      path.quadraticBezierTo(p1.dx, p1.dy, midPoint.dx, midPoint.dy);
    }

    // Draw last segment to last point
    path.lineTo(points.last.dx, points.last.dy);

    canvas.drawPath(path, paintLine);

    // Draw data points
    for (final point in points) {
      canvas.drawCircle(point, 4, paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
