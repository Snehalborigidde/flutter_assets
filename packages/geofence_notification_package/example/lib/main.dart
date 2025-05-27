import 'package:flutter/material.dart';
import 'package:geofence_notification_package/geofence_notification_package.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geofence Notification Example',
      home: GeofencePage(),
    );
  }
}

class GeofencePage extends StatefulWidget {
  @override
  State<GeofencePage> createState() => _GeofencePageState();
}

class _GeofencePageState extends State<GeofencePage> {
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Geofence Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: latController, decoration: InputDecoration(labelText: 'Latitude')),
            TextField(controller: lngController, decoration: InputDecoration(labelText: 'Longitude')),
            TextField(controller: radiusController, decoration: InputDecoration(labelText: 'Radius in meters')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GeofenceHandler.startGeofencing(
                  lat: latController.text,
                  lng: lngController.text,
                  radius: radiusController.text,
                );
              },
              child: Text("Start Geofencing"),
            ),
            ElevatedButton(
              onPressed: () async {
                await GeofenceHandler.stopGeofencing();
                // Resetting the text fields
                setState(() {
                  latController.text = "";
                  lngController.text = "";
                  radiusController.text = "";
                });
                // Optional: show a SnackBar as extra user feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Geofencing stopped and inputs cleared.")),
                );
              },
              child: Text("Stop Geofencing"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    latController.dispose();
    lngController.dispose();
    radiusController.dispose();
    super.dispose();
  }
}
