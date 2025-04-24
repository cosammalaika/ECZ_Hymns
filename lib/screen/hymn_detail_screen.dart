// ignore_for_file: library_private_types_in_public_api

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
      // Small delay to ensure widget is fully rendered
      await Future.delayed(const Duration(milliseconds: 100));

      RenderRepaintBoundary boundary = 
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception("Failed to convert image to byte data.");
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imgFile = File('${directory.path}/hymn.png');

      await imgFile.writeAsBytes(pngBytes);

      // Use latest method for sharing files
      await Share.shareXFiles([XFile(imgFile.path)],
          text: 'Let this hymn inspire you: ${widget.hymn.title}.');
    } catch (e) {
      debugPrint('Error capturing hymn: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF004d73),
        title: const Row(
          children: [
            Text(
              'Hymns',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              ' Alive',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          _buildIconButton('assets/icons/zoom-in.png', () {
            setState(() {
              fontSize = (fontSize < 22) ? fontSize + 2 : 22;
            });
          }),
          _buildIconButton('assets/icons/zoom-out.png', () {
            setState(() {
              fontSize = (fontSize > 14) ? fontSize - 2 : 14;
            });
          }),
          _buildIconButton('assets/icons/send.png', _captureAndSharePng),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white,
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
                _buildVerse(widget.hymn.verses[0]),
                if (widget.hymn.chorus.isNotEmpty) _buildChorus(widget.hymn.chorus),
                for (var i = 1; i < widget.hymn.verses.length; i++) _buildVerse(widget.hymn.verses[i]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerse(List<String> lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var line in lines)
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
    );
  }

  Widget _buildChorus(List<String> lines) {
    return Column(
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
        for (var line in lines)
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
    );
  }

  Widget _buildIconButton(String assetPath, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        height: 20,
        child: Image.asset(assetPath),
      ),
    );
  }
}
