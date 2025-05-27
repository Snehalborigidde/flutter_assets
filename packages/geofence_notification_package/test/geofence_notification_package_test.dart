// import 'package:flutter_test/flutter_test.dart';
// import 'package:geofence_notification_package/geofence_notification_package.dart';
// import 'package:mockito/mockito.dart';
// import 'package:geofence_flutter/geofence_flutter.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // Create Mock Classes
// class MockGeofenceFlutter extends Mock implements GeofenceFlutter {}
//
// class MockNotificationPlugin extends Mock
//     implements FlutterLocalNotificationsPlugin {}
//
// void main() {
//   group('GeofenceHandler', () {
//     // Mocked instances
//     late MockGeofenceFlutter mockGeofenceFlutter;
//     late MockNotificationPlugin mockNotificationPlugin;
//
//     setUp(() {
//       mockGeofenceFlutter = MockGeofenceFlutter();
//       mockNotificationPlugin = MockNotificationPlugin();
//     });
//
//     test('Should start geofencing without error', () async {
//       // Arrange
//       final lat = '18.5204';
//       final lng = '73.8567';
//       final radius = '100';
//
//       // Act
//       await GeofenceHandler.startGeofencing(
//         lat: lat,
//         lng: lng,
//         radius: radius,
//       );
//
//       // Assert (no errors means success)
//       expect(true, isTrue);
//     });
//
//     test('Should stop geofencing without error', () async {
//       // Act
//       await GeofenceHandler.stopGeofencing();
//
//       // Assert
//       expect(true, isTrue);
//     });
//
//     test('Handles invalid lat/lng gracefully', () async {
//       // Act
//       try {
//         await GeofenceHandler.startGeofencing(
//           lat: 'invalid',
//           lng: 'invalid',
//           radius: '100',
//         );
//       } catch (e) {
//         // Assert
//         expect(e, isA<FormatException>());
//       }
//     });
//
//     test('Handles empty radius gracefully', () async {
//       // Act
//       try {
//         await GeofenceHandler.startGeofencing(
//           lat: '18.5204',
//           lng: '73.8567',
//           radius: '',
//         );
//       } catch (e) {
//         // Assert
//         expect(e, isA<FormatException>());
//       }
//     });
//   });
// }
