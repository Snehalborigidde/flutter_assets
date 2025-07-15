import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';

class VideoUploadPage extends StatefulWidget {
  @override
  _VideoUploadPageState createState() => _VideoUploadPageState();
}

class _VideoUploadPageState extends State<VideoUploadPage> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveVideo() async {
    if (_titleController.text.isEmpty || _urlController.text.isEmpty) return;

    setState(() => _isLoading = true);

    await FirebaseFirestore.instance.collection('videos').add({
      'title': _titleController.text.trim(),
      'url': _urlController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      _titleController.clear();
      _urlController.clear();
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('✅ Video metadata saved!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video Metadata"),
        backgroundColor: AppColors.appBarBackground,
        foregroundColor: AppColors.appBarForeground,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Video Title"),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: "Video URL"),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _saveVideo,
              child: Text("Save to Firestore"),
            ),
          ],
        ),
      ),
    );
  }
}
