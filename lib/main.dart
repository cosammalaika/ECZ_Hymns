// main.dart
import 'package:flutter/material.dart';
import 'screen/hymn_list_screen.dart';

void main() {
  runApp(const HymnBookApp());
}

class HymnBookApp extends StatelessWidget {
  const HymnBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hymns Forgotten',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HymnListScreen(
        fileName: 'hymns',
      ),
      
    );
  }
}
