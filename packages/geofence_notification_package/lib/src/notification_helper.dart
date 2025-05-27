import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(initSettings);
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    await Permission.notification.request();
  }

  static Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'geofence_channel',
      'Geofence Alerts',
      channelDescription: 'Notification for geofence triggers',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _plugin.show(0, title, body, details);
  }
}
