// import 'package:local_auth/local_auth.dart';
//
// class BiometricAuth {
//   final LocalAuthentication _auth = LocalAuthentication();
//
//   /// Trigger biometric authentication
//   Future<bool> authenticate() async {
//     try {
//       final canCheckBiometrics = await _auth.canCheckBiometrics;
//       final isDeviceSupported = await _auth.isDeviceSupported();
//
//       if (canCheckBiometrics && isDeviceSupported) {
//         return await _auth.authenticate(
//           localizedReason: 'Authenticate to access the app',
//           options: const AuthenticationOptions(
//             biometricOnly: true,
//             stickyAuth: true,
//           ),
//         );
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Biometric auth error: $e');
//       return false;
//     }
//   }
// }


// import 'package:local_auth/local_auth.dart';
//
// class BiometricAuth {
//   final _auth = LocalAuthentication();
//
//   Future<bool> authenticate() async {
//     try {
//       // Check if biometrics are available
//       final canCheck = await _auth.canCheckBiometrics;
//       final isDeviceSupported = await _auth.isDeviceSupported();
//       final enrolled = await _auth.getAvailableBiometrics();
//
//       if (!canCheck || !isDeviceSupported || enrolled.isEmpty) {
//         return false; // No biometric available/enrolled
//       }
//
//       return await _auth.authenticate(
//         localizedReason: 'Authenticate using biometrics',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//           stickyAuth: true,
//         ),
//       );
//     } catch (e) {
//       print('Biometric error: $e');
//       return false;
//     }
//   }
// }

import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      final biometrics = await _auth.getAvailableBiometrics();

      if (!canCheck || !isSupported || biometrics.isEmpty) {
        print("❌ Biometrics not available/enrolled");
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'Use your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('❌ Biometric error: $e');
      return false;
    }
  }
}

