
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';

class PDFUploadPage extends StatefulWidget {
  const PDFUploadPage({super.key});

  @override
  State<PDFUploadPage> createState() => _PDFUploadPageState();
}

class _PDFUploadPageState extends State<PDFUploadPage> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  Future<void> _savePDFMetadata() async {
    final title = _titleController.text.trim();
    final url = _urlController.text.trim();

    if (title.isEmpty || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Both fields are required")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('pdfs').add({
      'title': title,
      'url': url,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add PDF"),
        backgroundColor: AppColors.appBarBackground,
        foregroundColor: AppColors.appBarForeground,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "PDF Title"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: "PDF URL"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save PDF Info"),
              onPressed: _savePDFMetadata,
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
//
// class PDFUploadPage extends StatefulWidget {
//   const PDFUploadPage({super.key});
//
//   @override
//   State<PDFUploadPage> createState() => _PDFUploadPageState();
// }
//
// class _PDFUploadPageState extends State<PDFUploadPage> {
//   String? fileName;
//   String? base64PDF;
//
//   Future<void> pickAndUploadPDF() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//
//     if (result != null && result.files.single.path != null) {
//       final file = File(result.files.single.path!);
//       final bytes = await file.readAsBytes();
//       final base64String = base64Encode(bytes);
//
//       setState(() {
//         fileName = path.basename(file.path);
//         base64PDF = base64String;
//       });
//
//       // Save to Firestore
//       await FirebaseFirestore.instance.collection('pdfs').add({
//         'title': fileName,
//         'base64': base64String,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ PDF uploaded!')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload PDF')),
//       body: Center(
//         child: ElevatedButton.icon(
//           icon: const Icon(Icons.upload_file),
//           label: const Text('Pick and Upload PDF'),
//           onPressed: pickAndUploadPDF,
//         ),
//       ),
//     );
//   }
// }
