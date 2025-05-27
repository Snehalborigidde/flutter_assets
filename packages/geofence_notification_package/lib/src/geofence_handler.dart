import 'dart:async';
import 'package:geofence_flutter/geofence_flutter.dart';
import 'notification_helper.dart';

class GeofenceHandler {
  static StreamSubscription<GeofenceEvent>? _subscription;
  static Stream<GeofenceEvent>? _broadcastStream;

  static Future<void> startGeofencing({
    required String lat,
    required String lng,
    required String radius,
  }) async {
    try {
      await NotificationHelper.initialize();

      await Geofence.startGeofenceService(
        pointedLatitude: lat,
        pointedLongitude: lng,
        radiusMeter: radius,
        eventPeriodInSeconds: 10,
      );

      _broadcastStream ??= Geofence.getGeofenceStream()?.asBroadcastStream();

      if (_subscription == null && _broadcastStream != null) {
        _subscription = _broadcastStream!.listen((event) {
          NotificationHelper.showNotification(
            "Geofence Triggered",
            event.toString(),
          );
        });
      }
    } catch (e, stacktrace) {
      print("Error starting geofencing: $e");
      print(stacktrace);
    }
  }

  static Future<void> stopGeofencing() async {
    try {
      Geofence.stopGeofenceService();
      await NotificationHelper.showNotification("Geofencing Stopped", "Geofencing has been stopped.");
      await _subscription?.cancel();
      _subscription = null;
      // You can add any reset logic here if needed in the package,
      // but usually resetting UI is better handled by the app UI code.
    } catch (e) {
      print("Error stopping geofencing: $e");
    }
  }
}
