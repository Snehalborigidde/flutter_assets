

import 'package:flutter/material.dart';
import 'package:flutter_custom_chart/flutter_custom_chart.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({super.key});

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  final FocusNode x = FocusNode();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  List<Map<String, dynamic>> bars = [];

  @override
  void dispose() {
    x.dispose();
    labelController.dispose();
    valueController.dispose();
    super.dispose();
  }

  void addBar() {
    final String label = labelController.text.trim();
    final double? value = double.tryParse(valueController.text);
    if (label.isNotEmpty && value != null) {
      setState(() {
        bars.add({'label': label, 'value': value});
        labelController.clear();
        valueController.clear();
        FocusScope.of(context).requestFocus(x);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<BarChartData> chartData = bars
        .map((bar) => BarChartData(label: bar['label'], value: bar['value']))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ Handles keyboard overflow
      appBar: AppBar(title: const Text('Bar Chart')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                focusNode: x,
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Value'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: addBar, child: const Text('Add Bar')),
              const SizedBox(height: 24),

              /// ✅ Chart Area
              if (chartData.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: BarChart(
                    data: chartData,
                    //barColor: Colors.deepPurple,
                  ),
                )
              else
                const Text('Add bars to see the chart'),

              const SizedBox(height: 24),

              const Text(
                'Bar List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              /// ✅ List of Bars
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bars.length,
                itemBuilder: (context, index) {
                  final bar = bars[index];
                  return ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: Text('${bar['label']}'),
                    trailing: Text('${bar['value']}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
