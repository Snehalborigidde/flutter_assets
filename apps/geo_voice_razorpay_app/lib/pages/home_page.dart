import 'package:flutter/material.dart';
import 'package:geo_voice_razorpay_app/pages/razorpay_page.dart';
import 'package:geo_voice_razorpay_app/pages/voice_to_text_page.dart';

import 'geofence_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Combined Demo App')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  GeofenceHomePage())),
            child: const Text('Geofence'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  VoicePage())),
            child: const Text('Voice to Text'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  RazorpayHomePage())),
            child: const Text('Razorpay'),
          ),
        ],
      ),
    );
  }
}
