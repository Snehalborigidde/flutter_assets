import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinAuth {
  final _storage = const FlutterSecureStorage();
  static const _pinKey = 'user_pin';

  /// Save PIN securely
  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  /// Check if PIN exists
  Future<bool> isPinSet() async {
    final pin = await _storage.read(key: _pinKey);
    return pin != null;
  }

  /// Verify entered PIN
  Future<bool> verifyPin(String inputPin) async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin == inputPin;
  }

  /// Optional: Reset PIN
  Future<void> resetPin() async {
    await _storage.delete(key: _pinKey);
  }
}
