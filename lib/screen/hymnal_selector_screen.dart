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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Hymnal'),
      ),
      body: HymnsPageBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
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
    final bool isEnabled = collection.isAvailable;

    return Opacity(
      opacity: isEnabled ? 1 : 0.7,
      child: HymnsSurfaceCard(
        onTap: isEnabled
            ? () => Navigator.of(context).pop(collection.fileName)
            : null,
        borderSide: BorderSide(
          color: isSelected ? collection.accentColor : AppColors.outline,
          width: isSelected ? 1.5 : 1,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: collection.accentColor.withOpacity(0.12),
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
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (!isEnabled)
              const HymnsSectionPill(
                label: 'Coming soon',
                backgroundColor: AppColors.accentSoft,
                textColor: AppColors.primaryDeep,
              )
            else if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: collection.accentColor,
                size: 24,
              )
            else
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
