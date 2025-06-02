//
//
//
// import 'package:flutter/material.dart';
// import 'package:voice_to_text/voice_to_text.dart';
//
// class VoicePage extends StatefulWidget {
//   @override
//   State<VoicePage> createState() => _VoicePageState();
// }
//
// class _VoicePageState extends State<VoicePage> {
//   final VoiceService _voiceService = VoiceService();
//   String _spokenText = '';
//
//   void _start() async {
//     final granted = await _voiceService.requestPermissions();
//     if (granted) {
//       await _voiceService.startListening((text) {
//         setState(() {
//           _spokenText = text;
//         });
//       });
//     }
//   }
//
//   void _stop() async {
//     await _voiceService.stopListening();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Stopped listening')),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Voice to Text")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Text(_spokenText),
//             ElevatedButton(
//               onPressed: _start,
//               child: const Text("Start Listening"),
//             ),
//             ElevatedButton(
//               onPressed: _stop,
//               child: const Text("Stop Listening"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:voice_to_text/voice_to_text.dart';

class VoicePage extends StatefulWidget {
  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final VoiceService _voiceService = VoiceService();
  String _spokenText = '';
  bool _isListening = false;

  void _start() async {
    final granted = await _voiceService.requestPermissions();
    if (granted) {
      setState(() => _isListening = true);

      await _voiceService.startListening((text) {
        setState(() {
          _spokenText = text;
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Started listening')),
      );
    }
  }

  void _stop() async {
    await _voiceService.stopListening();
    setState(() => _isListening = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stopped listening')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice to Text")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text(_spokenText, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isListening ? null : _start,
                child: const Text("Start Listening"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isListening ? _stop : null,
                child: const Text("Stop Listening"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



