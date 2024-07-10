import 'package:flutter/material.dart';
import '../models/hymn.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;

  const HymnDetailScreen({super.key, required this.hymn});

  @override
  // ignore: library_private_types_in_public_api
  _HymnDetailScreenState createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  bool isFavorite = false;
  double fontSize = 16;

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
              'Hymns',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              ' Alive',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (fontSize < 20) {
                  fontSize += 2;
                  if (fontSize > 22) {
                    fontSize = 22;
                  }
                }
              });
            },
            icon: SizedBox(
              height: 20,
              child: Image.asset(
                'assets/icons/zoom-in.png',
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (fontSize > 14) {
                  fontSize -= 2;
                  if (fontSize < 14) {
                    fontSize = 14;
                  }
                }
              });
            },
            icon: SizedBox(
              height: 20,
              child: Image.asset(
                'assets/icons/zoom-out.png',
                color: const Color(0xFFFFFFFF),
              ),
            ),
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
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000046),
                ),
              ),
              const SizedBox(height: 16),
              // Render verses
              for (var verse in widget.hymn.verses)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var line in verse)
                      Text(
                        line,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000046),
                        ),
                      ),
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
                          color: Color(0xFF000046)),
                    ),
                    for (var line in widget.hymn.chorus)
                      Text(
                        line,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000046),
                        ),
                      ),
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
