// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../data/hymnal_catalog.dart';
import '../models/hymn.dart';
import '../theme/app_theme.dart';
import '../utils/share_position_origin.dart';
import '../widgets/hymns_ui.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;
  final HymnalCollection collection;

  const HymnDetailScreen({
    super.key,
    required this.hymn,
    required this.collection,
  });

  @override
  _HymnDetailScreenState createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  double fontSize = 18;
  final GlobalKey _globalKey = GlobalKey();
  final GlobalKey _shareButtonKey = GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      final Rect sharePositionOrigin = sharePositionOriginForContext(
        context,
        triggerKey: _shareButtonKey,
      );

      await Future.delayed(const Duration(milliseconds: 100));

      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert hymn to image data.');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imgFile = File('${directory.path}/hymn.png');

      await imgFile.writeAsBytes(pngBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[XFile(imgFile.path)],
          text: 'Let this hymn inspire you: ${widget.hymn.title}.',
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to share this hymn right now.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;
    final HymnalPalette palette = widget.collection.palette;
    final double topContentInset =
        MediaQuery.of(context).padding.top + kToolbarHeight + 12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 72,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ui.isDark
                    ? Color.alphaBlend(
                        palette.primary.withValues(alpha: 0.26),
                        ui.surfaceSecondary,
                      )
                    : palette.accentCool,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '#${widget.hymn.id}',
                style: textTheme.labelMedium?.copyWith(
                  color: ui.isDark ? Colors.white : palette.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: HymnsPageBackground(
        primaryColor: palette.primary,
        accentColor: palette.accent,
        accentCoolColor: palette.accentCool,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20, topContentInset, 20, 124),
          child: RepaintBoundary(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        palette.primary,
                        palette.primaryDeep,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: palette.shadow,
                        blurRadius: 26,
                        offset: Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.hymn.title,
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 29,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${widget.collection.title} • ${widget.collection.subtitle}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(
                            alpha: ui.isDark ? 0.86 : 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (int index = 0;
                    index < widget.hymn.verses.length;
                    index++) ...<Widget>[
                  _buildVerseCard(
                    context,
                    palette: palette,
                    ui: ui,
                    label: 'Verse ${index + 1}',
                    lines: widget.hymn.verses[index],
                  ),
                  if (index == 0 && widget.hymn.chorus.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 16),
                    _buildChorusCard(
                      context,
                      palette: palette,
                      ui: ui,
                    ),
                  ],
                  if (index != widget.hymn.verses.length - 1)
                    const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: HymnsSurfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: <Widget>[
              _ReaderControlButton(
                icon: Icons.remove_rounded,
                onTap: () {
                  setState(() {
                    fontSize = (fontSize > 15) ? fontSize - 1 : 15;
                  });
                },
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Reading size',
                      style: textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${fontSize.toStringAsFixed(0)} pt',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _ReaderControlButton(
                icon: Icons.add_rounded,
                onTap: () {
                  setState(() {
                    fontSize = (fontSize < 24) ? fontSize + 1 : 24;
                  });
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  key: _shareButtonKey,
                  style: FilledButton.styleFrom(
                    backgroundColor: palette.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _captureAndSharePng,
                  icon: const Icon(Icons.ios_share_rounded),
                  label: const Text('Share'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerseCard(
    BuildContext context, {
    required HymnalPalette palette,
    required HymnsUiPalette ui,
    required String label,
    required List<String> lines,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color versePillBackground = ui.isDark
        ? Color.alphaBlend(
            palette.primary.withValues(alpha: 0.24),
            ui.surfaceSecondary,
          )
        : palette.accentCool;

    return HymnsSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HymnsSectionPill(
            label: label,
            backgroundColor: versePillBackground,
            textColor: ui.isDark ? Colors.white : palette.primary,
          ),
          const SizedBox(height: 16),
          Text(
            lines.join('\n'),
            style: textTheme.bodyLarge?.copyWith(
              fontSize: fontSize,
              color: ui.textPrimary,
              height: 1.85,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChorusCard(
    BuildContext context, {
    required HymnalPalette palette,
    required HymnsUiPalette ui,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color chorusBackground = ui.isDark
        ? Color.alphaBlend(
            palette.accent.withValues(alpha: 0.12),
            ui.surface,
          )
        : palette.accentSoft;
    final Color chorusBorder = ui.isDark
        ? palette.accent.withValues(alpha: 0.34)
        : palette.accent.withValues(alpha: 0.75);
    final Color chorusPillBackground = ui.isDark
        ? Color.alphaBlend(
            palette.accent.withValues(alpha: 0.18),
            ui.surfaceSecondary,
          )
        : palette.accent.withValues(alpha: 0.28);
    final Color chorusTextColor =
        ui.isDark ? palette.accentSoft : palette.primaryDeep;

    return HymnsSurfaceCard(
      color: chorusBackground,
      borderSide: BorderSide(
        color: chorusBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HymnsSectionPill(
            label: 'Chorus',
            backgroundColor: chorusPillBackground,
            textColor: chorusTextColor,
            icon: Icons.music_note_rounded,
          ),
          const SizedBox(height: 16),
          Text(
            widget.hymn.chorus.join('\n'),
            style: textTheme.bodyLarge?.copyWith(
              fontSize: fontSize,
              color: chorusTextColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReaderControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ReaderControlButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
    );
  }
}
