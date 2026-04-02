import 'package:flutter/material.dart';

import '../data/hymnal_catalog.dart';
import '../theme/app_theme.dart';
import '../widgets/hymns_ui.dart';

class HymnalSelectorScreen extends StatelessWidget {
  final String selectedFileName;

  const HymnalSelectorScreen({
    super.key,
    required this.selectedFileName,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;
    final HymnalCollection activeCollection =
        hymnalCollectionForFile(selectedFileName);
    final HymnalPalette palette = activeCollection.palette;
    final double topContentInset =
        MediaQuery.of(context).padding.top + kToolbarHeight + 12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Select Hymnal',
          style: textTheme.titleLarge?.copyWith(
            color: ui.textPrimary,
          ),
        ),
      ),
      body: HymnsPageBackground(
        primaryColor: palette.primary,
        accentColor: palette.accent,
        accentCoolColor: palette.accentCool,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, topContentInset, 20, 32),
          children: <Widget>[
            for (final HymnalCollection collection in hymnals) ...<Widget>[
              _HymnalOptionCard(
                collection: collection,
                isSelected: collection.fileName == selectedFileName,
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _HymnalOptionCard extends StatelessWidget {
  final HymnalCollection collection;
  final bool isSelected;

  const _HymnalOptionCard({
    required this.collection,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;
    final bool isEnabled = collection.isAvailable;
    final Color optionIconBackground = collection.accentColor.withOpacity(
      ui.isDark ? 0.22 : 0.12,
    );
    final Color unavailablePillBackground = ui.isDark
        ? Color.alphaBlend(collection.accentColor.withOpacity(0.18), ui.surfaceSecondary)
        : collection.palette.accentSoft;
    final Color unavailablePillText =
        ui.isDark ? collection.palette.accentSoft : collection.palette.primaryDeep;

    return Opacity(
      opacity: isEnabled ? 1 : 0.7,
      child: HymnsSurfaceCard(
        onTap: isEnabled
            ? () => Navigator.of(context).pop(collection.fileName)
            : null,
        borderSide: BorderSide(
          color: isSelected ? collection.accentColor : ui.outline,
          width: isSelected ? 1.5 : 1,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: optionIconBackground,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                collection.icon,
                color: collection.accentColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    collection.title,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    collection.subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: ui.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (!isEnabled)
              HymnsSectionPill(
                label: 'Coming soon',
                backgroundColor: unavailablePillBackground,
                textColor: unavailablePillText,
              )
            else if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: collection.accentColor,
                size: 24,
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: ui.textSecondary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
