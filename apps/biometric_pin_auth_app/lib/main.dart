import 'package:biometric_secure_auth_package/biometric_secure_auth_package.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isAuthenticated ? 'Welcome' : 'Secure Login'),
        actions: [
          if (_isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                setState(() {
                  _isAuthenticated = false;
                });
              },
            )
        ],
      ),
      body: Center(
        child: _isAuthenticated
            ? const Text(
          "🎉 Access Granted!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
            : AuthGate(
          onAuthenticated: () {
            setState(() {
              _isAuthenticated = true;
            });
          },
        ),
      ),
    );
  }
}



