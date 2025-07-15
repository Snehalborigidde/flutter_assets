
import 'package:chatbot_app/presentation/screens/pdf/pdf_upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/app_theme.dart';

class PDFListPage extends StatelessWidget {
  const PDFListPage({super.key});

  Future<void> _openPDF(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open PDF: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Library"),
        backgroundColor: AppColors.appBarBackground,
        foregroundColor: AppColors.appBarForeground,),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pdfs')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Error loading PDFs');
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title']),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => _openPDF(data['url']),
                ),
              );
            },
          );
        },
      ),
    floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PDFUploadPage()));
        },
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:io';
//
// import 'package:chatbot_app/presentation/screens/pdf/pdf_upload_screen.dart';
// import 'package:chatbot_app/presentation/screens/pdf/pdf_viewer_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:open_file_plus/open_file_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class PDFListPage extends StatelessWidget {
//   const PDFListPage({super.key});
//
//   // Future<void> _viewPDF(BuildContext context, String base64, String title) async {
//   //   final bytes = base64Decode(base64);
//   //
//   //   final dir = await getTemporaryDirectory();
//   //   final filePath = '${dir.path}/$title';
//   //   final file = File(filePath);
//   //
//   //   await file.writeAsBytes(bytes);
//   //
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (_) => PDFViewPage(file: file, title: title),
//   //     ),
//   //   );
//   // }
//
//   Future<void> openBase64Pdf(BuildContext context, String base64Str, String fileName) async {
//     final bytes = base64Decode(base64Str);
//     final dir = await getTemporaryDirectory();
//     final file = File('${dir.path}/$fileName');
//     await file.writeAsBytes(bytes);
//     await OpenFile.open(file.path);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => PDFViewPage(file: file, title: fileName),
//       ),
//     );
//   }
//
//   Future<void> openPdfInBrowser(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       throw '❌ Could not launch $url';
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('PDF Library')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('pdfs').orderBy('timestamp', descending: true).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return const Center(child: Text('❌ Error loading PDFs'));
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//
//           final docs = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data() as Map<String, dynamic>;
//               return ListTile(
//                 title: Text(data['title'] ?? 'Untitled PDF'),
//                 // trailing: IconButton(
//                 //   icon: const Icon(Icons.picture_as_pdf),
//                 //   onPressed: () => _viewPDF(context, data['base64'], data['title']),
//                 // ),
//                 trailing: Wrap(
//                   spacing: 12, // space between two icons
//                   children: <Widget>[
//                 IconButton(
//                   icon: const Icon(Icons.picture_as_pdf),
//                   onPressed: () => openBase64Pdf(context, data['base64'], data['title']),
//                 ), // icon-1
//               IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () => openPdfInBrowser(data['url']),
//                 ), // icon-2
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => const PDFUploadPage()));
//         },
//       ),
//     );
//   }
// }
//
