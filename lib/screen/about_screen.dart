import 'package:flutter/material.dart';
import 'package:share/share.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ECZ Hymn App was developed by C&J Creative Solutions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _shareApp(context);
                },
                icon: Icon(Icons.share),
                label: Text('Share This'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement rate functionality
                },
                icon: Icon(Icons.star),
                label: Text('Rate This App'),
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
