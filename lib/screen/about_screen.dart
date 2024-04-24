// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: use_key_in_widget_constructors
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ECZ Hymn App was developed by C&J Creative Solutions',
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
