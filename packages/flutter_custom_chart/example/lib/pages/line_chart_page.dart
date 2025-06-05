
import 'package:flutter/material.dart';
import 'package:flutter_custom_chart/flutter_custom_chart.dart';


class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  final List<LineChartData> _dataPoints = [];
  final FocusNode _xFocus = FocusNode();

  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();

  void _addPoint() {
    final double? x = double.tryParse(_xController.text);
    final double? y = double.tryParse(_yController.text);

    if (x != null && y != null) {
      setState(() {
        _dataPoints.add(LineChartData(x: x, y: y));
        _xController.clear();
        _yController.clear();
      });
      // Request focus back to the X input field
      FocusScope.of(context).requestFocus(_xFocus);
    }
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(' Line Chart'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input Fields
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _xController,
                      focusNode: _xFocus,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'X value'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _yController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Y value'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addPoint,
                    child: const Text('Add'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Live Chart
              Expanded(
                child: LineChart(
                  data: _dataPoints,
                  lineColor: Colors.teal,
                  strokeWidth: 3.0,
                ),
              ),

              const SizedBox(height: 10),
              Text("Points: ${_dataPoints.map((e) => "(${e.x}, ${e.y})").join(', ')}")
            ],
          ),
        ),
      );
  }
}
