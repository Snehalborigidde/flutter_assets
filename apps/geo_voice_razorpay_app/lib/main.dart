import 'package:flutter/material.dart';
import 'package:geo_voice_razorpay_app/pages/home_page.dart';


void main() {
  runApp(const MyCombinedApp());
}

class MyCombinedApp extends StatelessWidget {
  const MyCombinedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combined Demo App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}
