import 'package:flutter/material.dart';
import 'package:biometric_secure_auth_package/src/biometric_auth.dart';
import 'package:biometric_secure_auth_package/src/pin_auth.dart';

class AuthGate extends StatefulWidget {
  final VoidCallback onAuthenticated;

  const AuthGate({super.key, required this.onAuthenticated});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _pinController = TextEditingController();
  final PinAuth _pinAuth = PinAuth();
  final BiometricAuth _biometricAuth = BiometricAuth();
  bool _isSettingPin = false;

  @override
  void initState() {
    super.initState();
    _checkIfPinExists();
  }

  Future<void> _checkIfPinExists() async {
    final exists = await _pinAuth.isPinSet();
    setState(() {
      _isSettingPin = !exists;
    });
  }

  Future<void> _handleSubmit() async {
    final pin = _pinController.text.trim();
    if (pin.length != 4) return;

    if (_isSettingPin) {
      await _pinAuth.savePin(pin);
      setState(() {
        _isSettingPin = false;
        _pinController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PIN set successfully. Please log in.")),
      );
    } else {
      final isValid = await _pinAuth.verifyPin(pin);
      if (isValid) {
        widget.onAuthenticated();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid PIN")));
      }
    }
  }

  Future<void> _handleBiometricLogin() async {
    final biometricSuccess = await _biometricAuth.authenticate();
    if (biometricSuccess) {
      widget.onAuthenticated();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Biometric failed. Make sure it's set up on your device.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isSettingPin ? 'Set a 4-digit PIN' : 'Enter your PIN',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'PIN',
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text(_isSettingPin ? 'Set PIN' : 'Login'),
          ),

          // ✅ Biometric login button (only if already set PIN)
          if (!_isSettingPin)
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint),
              label: const Text('Use Biometric'),
              onPressed: _handleBiometricLogin,
            ),
        ],
      ),
    );
  }
}
