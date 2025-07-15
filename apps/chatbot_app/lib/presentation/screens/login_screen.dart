//working
// // lib/screens/login_page.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'home_screen.dart'; // 👈 Add this import

class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Microsoft Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final token = await _authService.signIn();
            print("✅ Access Token: $token");
            if (token != null) {
              print("✅ Access Token: $token");

              // ✅ Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("✅ Login successful!!"),
                  backgroundColor: Colors.green,
                ),
              );
              /// 👇 Navigate to ChatBot screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            } else {
              print("❌ Login failed");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login failed. Try again.")),
              );
            }
          },
          child: Text("Login with Microsoft"),
        ),
      ),
    );
  }
}



