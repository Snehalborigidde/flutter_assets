import 'package:flutter/material.dart';
import 'package:voice_to_text/voice_to_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoicePage(),
    );
  }
}

class VoicePage extends StatefulWidget {
  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final VoiceService _voiceService = VoiceService();
  String _spokenText = '';

  void _start() async {
    final granted = await _voiceService.requestPermissions();
    if (granted) {
      await _voiceService.startListening((text) {
        setState(() {
          _spokenText = text;
        });
      });
    }
  }

  void _stop() async {
    await _voiceService.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice to Text")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(_spokenText),
            ElevatedButton(
              onPressed: _start,
              child: const Text("Start Listening"),
            ),
            ElevatedButton(
              onPressed: _stop,
              child: const Text("Stop Listening"),
            ),
          ],
        ),
      ),
    );
  }
}



