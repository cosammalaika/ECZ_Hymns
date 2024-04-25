// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: use_key_in_widget_constructors
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF004d73),
        title: const Row(
          children: [
            Text(
              'About',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              ' App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hymn Alive App was developed by C&J Creative Solutions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _shareApp(context);
                },
                icon: const Icon(Icons.share),
                label: const Text('Share This'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement rate functionality
                },
                icon: const Icon(Icons.star),
                label: const Text('Rate This App'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _shareApp(BuildContext context) {
    try {
      Share.share(
        'ECZ Hymn App was developed by C&J Creative Solutions. Check it out!',
        subject: 'Check out this app!', // Optional subject
      );
    } catch (e) {
      print('Error sharing: $e');
    }
  }
}
