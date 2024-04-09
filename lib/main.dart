// main.dart
import 'package:flutter/material.dart';
import 'screen/hymn_list_screen.dart';

void main() {
  runApp(HymnBookApp());
}

class HymnBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ECZ Hymns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HymnListScreen(
        fileName: 'hymns',
      ),
      
    );
  }
}
