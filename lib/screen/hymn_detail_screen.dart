import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/hymn.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;

  const HymnDetailScreen({super.key, required this.hymn});

  @override
  _HymnDetailScreenState createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  bool isFavorite = false;
  double fontSize = 16;
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = File('$directory/hymn.png');
      await imgFile.writeAsBytes(pngBytes);

      await Share.shareFiles([imgFile.path],
          text: 'Let this hymn inspire you: ${widget.hymn.title}.');
    } catch (e) {
      print(e.toString());
    }
  }

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
              ),
            ),
          ),
          IconButton(
            onPressed: _captureAndSharePng,
            icon: SizedBox(
              height: 30,
              child: Image.asset(
                'assets/icons/send.png',
              ),
            ),
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white, // Solid background color
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.hymn.id}. ${widget.hymn.title}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000046),
                  ),
                ),
                const SizedBox(height: 16),
                // Render first verse
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var line in widget.hymn.verses[0])
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
                // Render chorus after first verse
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
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF000046),
                          ),
                        ),
                      const SizedBox(height: 15),
                    ],
                  ),
                // Render remaining verses
                for (var i = 1; i < widget.hymn.verses.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var line in widget.hymn.verses[i])
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
