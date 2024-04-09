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
        title: Text('Hymn ${widget.hymn.id}'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                fontSize += 2;
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (fontSize > 2) {
                  fontSize -= 2;
                }
              });
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.hymn.id} ${widget.hymn.title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Render verses
              for (var verse in widget.hymn.verses)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var line in verse)
                      Text(line, style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: 15),
                  ],
                ),
              // Render chorus
              if (widget.hymn.chorus.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chorus',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    for (var line in widget.hymn.chorus)
                      Text(line, style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: 15),
                  ],
                ),
              // Render added chorus
              if (widget.hymn.addedChorus.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Added Chorus',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    for (var line in widget.hymn.addedChorus)
                      Text(line, style: TextStyle(fontSize: fontSize)),
                    SizedBox(height: 15),
                  ],
                ),
            ],
          ),
        ),
      ),

    );
  }
}
