import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geofence_notification_package/geofence_notification_package.dart';

class GeofenceHomePage extends StatefulWidget {
  @override
  State<GeofenceHomePage> createState() => _GeofenceHomePageState();
}

class _GeofenceHomePageState extends State<GeofenceHomePage> {
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _radiusController = TextEditingController();

  bool isGeofencingStarted = false;

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  Future<void> _startGeofencing() async {
    if (await Permission.location.request().isGranted) {
      final lat = _latitudeController.text;
      final lng = _longitudeController.text;
      final radius = _radiusController.text;

      if (lat == null || lng == null || radius == null) {
        _showSnackBar('Enter valid coordinates and radius');
        return;
      }

      await GeofenceHandler.startGeofencing(
        lat: lat,
        lng: lng,
        radius: radius,

      );

      setState(() {
        isGeofencingStarted = true;
      });

      _showSnackBar('✅ Geofencing started');
    } else {
      _showSnackBar('❌ Location permission denied');
    }
  }

  Future<void> _stopGeofencing() async {
    await GeofenceHandler.stopGeofencing();

    _latitudeController.clear();
    _longitudeController.clear();
    _radiusController.clear();

    setState(() {
      isGeofencingStarted = false;
    });

    _showSnackBar('🛑 Geofencing stopped & reset');
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geofence Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_latitudeController, 'Latitude'),
            _buildTextField(_longitudeController, 'Longitude'),
            _buildTextField(_radiusController, 'Radius (meters)'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGeofencing,
              child: Text('Start Geofencing'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isGeofencingStarted ? _stopGeofencing : null,
              child: Text('Stop Geofencing'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
