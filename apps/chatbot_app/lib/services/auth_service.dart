// lib/services/auth_service.dart
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String clientId = '78d4b086-fe4d-4143-8421-6b340628b2af'; // From Azure Portal
  final String redirectUrl = 'msauth://com.example.chatbot_app';
 // final String issuer = 'https://login.microsoftonline.com/578de98b-78d8-4e73-9b0d-98a9617a21b7/v2.0';
  final List<String> scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
  ];

  Future<String?> signIn() async {
    try {
      final AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
         // discoveryUrl: '$issuer/.well-known/openid-configuration',
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
            tokenEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
          ),
         // issuer: issuer,
          scopes: scopes,
         // promptValues: ['login'],
          promptValues: ['select_account'],

        ),
      );

      if (result != null && result.accessToken != null) {
        await _secureStorage.write(key: 'access_token', value: result.accessToken);
        await _secureStorage.write(key: 'refresh_token', value: result.refreshToken);
        print('✅ ACCESS TOKEN: ${result.accessToken}');

        return result.accessToken;

      }
    } catch (e) {
      print("❌ Sign-in failed: $e");
    }
    return null;
  }
}


// // lib/services/auth_service.dart
// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';
//
// class AuthService {
//   final FlutterAppAuth _appAuth = FlutterAppAuth();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//
//   final String clientId = '78d4b086-fe4d-4143-8421-6b340628b2af';
//   final String redirectUrl = 'msauth://com.example.chatbot_app';
//   final String issuer = 'https://login.microsoftonline.com/consumers/v2.0'; // 👈 Use `consumers` for personal accounts
//
//   final List<String> scopes = [
//     'openid',
//     'profile',
//     'email',
//     'offline_access',
//   ];
//
//   Future<Map<String, dynamic>?> signIn() async {
//     try {
//       final result = await _appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           clientId,
//           redirectUrl,
//           serviceConfiguration: AuthorizationServiceConfiguration(
//             authorizationEndpoint:
//             'https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize',
//             tokenEndpoint:
//             'https://login.microsoftonline.com/consumers/oauth2/v2.0/token',
//           ),
//           scopes: scopes,
//           promptValues: ['select_account'], // 👈 Better than 'login'
//         ),
//       );
//
//       if (result != null && result.accessToken != null) {
//         await _secureStorage.write(key: 'access_token', value: result.accessToken);
//         await _secureStorage.write(key: 'refresh_token', value: result.refreshToken);
//         print('✅ ACCESS TOKEN: ${result.accessToken}');
//
//         final idToken = result.idToken;
//         if (idToken != null) {
//           final payload = _parseJwtPayload(idToken);
//           return payload; // includes email, name, etc.
//         }
//       }
//     } catch (e) {
//       print("❌ Sign-in failed: $e");
//     }
//     return null;
//   }
//
//   Map<String, dynamic> _parseJwtPayload(String token) {
//     final parts = token.split('.');
//     final payload = base64Url.normalize(parts[1]);
//     final decoded = utf8.decode(base64Url.decode(payload));
//     return json.decode(decoded);
//   }
//
//   Future<void> signOut() async {
//     await _secureStorage.deleteAll();
//   }
// }
