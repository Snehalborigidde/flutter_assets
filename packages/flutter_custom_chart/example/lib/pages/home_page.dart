import 'package:flutter/material.dart';
import 'bar_chart_page.dart';
import 'line_chart_page.dart';
import 'pie_chart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chart Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Line Chart"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LineChartPage())),
            ),
            ElevatedButton(
              child: const Text("Bar Chart"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BarChartPage())),
            ),
            ElevatedButton(
              child: const Text("Pie Chart"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PieChartPage())),
            ),
          ],
        ),
      ),
    );
  }
}
