// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/app_theme.dart';
import '../utils/share_position_origin.dart';
import '../widgets/brand_wordmark.dart';
import '../widgets/hymns_ui.dart';
import '../widgets/theme_mode_toggle_button.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final Future<PackageInfo> _packageInfoFuture;
  final GlobalKey _appBarShareButtonKey = GlobalKey();
  final GlobalKey _ctaShareButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = PackageInfo.fromPlatform();
  }

  Future<void> _shareApp(GlobalKey triggerKey) {
    return SharePlus.instance.share(
      ShareParams(
        text:
            'Tap into the serenity of hymns! Get Hymns Alive on the App Store and Google Play now. Experience the peace and joy in every note. 🎶 #HymnsAlive #DownloadNow',
        sharePositionOrigin: sharePositionOriginForContext(
          context,
          triggerKey: triggerKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;
    final double topContentInset =
        MediaQuery.of(context).padding.top + kToolbarHeight + 12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: const Text('About'),
        actions: <Widget>[
          const ThemeModeToggleButton(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              key: _appBarShareButtonKey,
              icon: const Icon(Icons.share_outlined),
              onPressed: () => _shareApp(_appBarShareButtonKey),
            ),
          ),
        ],
      ),
      body: HymnsPageBackground(
        child: FutureBuilder<PackageInfo>(
          future: _packageInfoFuture,
          builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
            final String version = snapshot.hasData
                ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                : 'Version loading...';

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20, topContentInset, 20, 32),
              children: <Widget>[
                HymnsSurfaceCard(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 94,
                        height: 94,
                        decoration: BoxDecoration(
                          color: ui.surfaceSecondary,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Image.asset('assets/images/hymns.png'),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const BrandWordmark(
                        size: 30,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'A calm offline companion for worship, reflection, and hymn reading.',
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          HymnsSectionPill(
                            label: version,
                            icon: Icons.verified_rounded,
                          ),
                          const HymnsSectionPill(
                            label: 'Offline library',
                            icon: Icons.download_done_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                HymnsSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Why it feels better',
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.search_rounded,
                        title: 'Fast search',
                        description:
                            'Jump to hymns quickly by title or hymn number.',
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.text_fields_rounded,
                        title: 'Comfortable reading',
                        description:
                            'Adjust text size and enjoy better spacing for long verses.',
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.language_rounded,
                        title: 'Multiple hymnals',
                        description:
                            'Browse language collections in one calm, consistent interface.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                HymnsSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'About Hymns Alive',
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Hymns Alive brings timeless hymns into a clean digital reading experience. It is designed for quiet reflection, worship moments, and dependable offline access wherever you are.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: ui.textPrimary,
                          height: 1.75,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                HymnsSurfaceCard(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Compiled by Cosam M. Malaika',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Designed to feel polished, quiet, and dependable for everyday hymn reading.',
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  key: _ctaShareButtonKey,
                  onPressed: () => _shareApp(_ctaShareButtonKey),
                  icon: const Icon(Icons.ios_share_rounded),
                  label: const Text('Share Hymns Alive'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: ui.surfaceSecondary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: ui.textPrimary,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
