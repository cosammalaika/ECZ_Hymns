import 'package:flutter/material.dart';
import '../models/hymn.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;

  HymnDetailScreen({required this.hymn});

  @override
  _HymnDetailScreenState createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  bool isFavorite = false;
  double fontSize = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ECZ Hymnal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         fontSize += 2;
        //       });
        //     },
        //     icon: const Icon(Icons.add),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         if (fontSize > 2) {
        //           fontSize -= 2;
        //         }
        //       });
        //     },
        //     icon: const Icon(Icons.remove),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.hymn.id} ${widget.hymn.title}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Render verses
              for (var verse in widget.hymn.verses)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var line in verse)
                      Text(line, style: TextStyle(fontSize: fontSize)),
                    const SizedBox(height: 15),
                  ],
                ),
              // Render chorus
              if (widget.hymn.chorus.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chorus',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    for (var line in widget.hymn.chorus)
                      Text(line,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontStyle: FontStyle.italic,
                          )),
                    const SizedBox(height: 15),
                  ],
                ),
              // Render added chorus
              if (widget.hymn.addedChorus.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Added Chorus',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    for (var line in widget.hymn.addedChorus)
                      Text(line, style: TextStyle(fontSize: fontSize)),
                    const SizedBox(height: 15),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
