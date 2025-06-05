
import 'package:flutter/material.dart';
import '../models/bar_chart_data.dart';

class BarChart extends StatelessWidget {
  final List<BarChartData> data;
  final List<Color>? barColors;

  const BarChart({
    super.key,
    required this.data,
    this.barColors,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BarChartPainter(data, barColors),
      size: Size.infinite,
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<BarChartData> data;
  final List<Color>? barColors;

  _BarChartPainter(this.data, this.barColors);

  @override
  void paint(Canvas canvas, Size size) {
    const double paddingLeft = 40;
    const double paddingBottom = 40;
    const double paddingTop = 20;
    const double paddingRight = 20;

    final chartWidth = size.width - paddingLeft - paddingRight;
    final chartHeight = size.height - paddingBottom - paddingTop;

    final paintAxis = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5;

    final paintGrid = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    final paintPoint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final origin = Offset(paddingLeft, size.height - paddingBottom);
    final xAxisEnd = Offset(size.width - paddingRight, size.height - paddingBottom);
    final yAxisEnd = Offset(paddingLeft, paddingTop);

    // Draw axes
    canvas.drawLine(origin, xAxisEnd, paintAxis); // X axis
    canvas.drawLine(origin, yAxisEnd, paintAxis); // Y axis

    if (data.isEmpty) return;

    final maxVal = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minVal = 0.0; // Optional: fixed minimum for baseline

    final textPainter = (String text) => TextPainter(
      text: TextSpan(text: text, style: const TextStyle(color: Colors.black, fontSize: 12)),
      textDirection: TextDirection.ltr,
    );

    void drawLabel(String text, Offset offset) {
      final tp = textPainter(text);
      tp.layout();
      tp.paint(canvas, offset);
    }

    // Draw Y axis grid lines and labels
    const gridCount = 5;
    final gridSpacing = chartHeight / gridCount;
    final valueSpacing = (maxVal - minVal) / gridCount;

    for (int i = 0; i <= gridCount; i++) {
      final y = paddingTop + chartHeight - gridSpacing * i;
      final value = minVal + valueSpacing * i;
      final labelOffset = Offset(paddingLeft - 35, y - 6);

      drawLabel(value.toStringAsFixed(0), labelOffset);
      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width - paddingRight, y), paintGrid);
    }

    // Bar width and spacing
    final barSpacing = chartWidth / (data.length * 2);
    final barWidth = barSpacing;

    // Default color list
    final defaultColors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
    ];

    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i].value / (maxVal == 0 ? 1 : maxVal)) * chartHeight;
      final x = paddingLeft + barSpacing * (2 * i + 0.5);
      final y = size.height - paddingBottom - barHeight;

      final color = (barColors != null && barColors!.length > i)
          ? barColors![i]
          : defaultColors[i % defaultColors.length];

      final paintBar = Paint()..color = color;

      // Draw bar
      canvas.drawRect(Rect.fromLTWH(x, y, barWidth, barHeight), paintBar);
      canvas.drawCircle(Offset(x + barWidth / 2, y), 5, paintPoint);

      // X-axis label
      final labelTp = textPainter(data[i].label);
      labelTp.layout();
      final labelX = x + barWidth / 2 - labelTp.width / 2;
      final labelY = size.height - paddingBottom + 4;
      labelTp.paint(canvas, Offset(labelX, labelY));
    }
  }


  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.barColors != barColors;
  }
}
