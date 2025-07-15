import 'package:chatbot_app/presentation/screens/pdf/pdf_list_screen.dart';
import 'package:chatbot_app/presentation/screens/video/video_list_screen.dart';
import 'package:flutter/material.dart';
import 'chat/chat_screen.dart';
import 'chat/chat_history_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
   // ChatPage(conversationId: '', currentUserId: '',),
    ChatPage(),
    HistoryPage(),
    PDFListPage(),
    VideoListPage(),
  ];

  final List<String> _titles = [
    'Chat',
    'History',
    'PDF',
    'Video',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.indigo,// indigo for selected icons
        unselectedItemColor: Colors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: 'PDF'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
        ],
      ),
    );
  }
}
