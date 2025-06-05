import 'package:flutter/material.dart';
import 'package:flutter_custom_chart/flutter_custom_chart.dart'; // your custom chart package

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  final FocusNode categoryFocus = FocusNode();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  final List<PieChartData> slices = [];

  @override
  void dispose() {
    categoryFocus.dispose();
    categoryController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  void addSlice() {
    final String category = categoryController.text.trim();
    final double? percentage = double.tryParse(percentageController.text);

    if (category.isNotEmpty && percentage != null) {
      setState(() {
        slices.add(PieChartData(category: category, percentage: percentage));
        categoryController.clear();
        percentageController.clear();
        FocusScope.of(context).requestFocus(categoryFocus);
      });
    }
  }



  double get totalPercentage =>
      slices.fold(0, (sum, item) => sum + item.percentage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Pie Chart')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                focusNode: categoryFocus,
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: percentageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Percentage'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: addSlice,
                child: const Text('Add Slice'),
              ),
              const SizedBox(height: 24),

              if (slices.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: PieChart(data: slices),
                )
              else
                const Text('Add some data to render the pie chart.'),

              const SizedBox(height: 24),
              Text(
                'Total: ${totalPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              const Text(
                'Slices:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: slices.length,
                itemBuilder: (context, index) {
                  final item = slices[index];
                  return ListTile(
                    leading: const Icon(Icons.pie_chart),
                    title: Text(item.category),
                    trailing: Text('${item.percentage}%'),
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
