//Only use the package: import for external packages,
// not your app’s own files unless your app is being built as a package (which it’s not in this case).


import 'pages/home_page.dart'; // ✅ CORRECT
import 'package:flutter/material.dart';
//import 'package:chart_implementation_app/pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

