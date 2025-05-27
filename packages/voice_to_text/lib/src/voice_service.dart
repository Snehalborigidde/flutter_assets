import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  Future<bool> requestPermissions() async {
    return await Permission.microphone.request().isGranted;
  }

  Future<void> startListening(Function(String text) onResult) async {
    final available = await _speech.initialize();
    if (available) {
      _isListening = true;
      _speech.listen(
        onResult: (result) {
          onResult(result.recognizedWords);
        },
      );
    }
  }

  Future<void> stopListening() async {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
    }
  }

  bool get isListening => _isListening;
}
