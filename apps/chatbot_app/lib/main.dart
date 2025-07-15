import 'package:chatbot_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chatbot_app/presentation/bloc/chat/chat_event.dart';
import 'package:chatbot_app/presentation/screens/home_screen.dart';
import 'package:chatbot_app/presentation/screens/login_screen.dart';
import 'package:chatbot_app/services/bot_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'constants/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(); // if you're using .env

  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!);

  runApp(
    BlocProvider(
      create: (_) => ChatBloc(BotService())..add(LoadMessages()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: LoginPage(),
    );
  }
}
