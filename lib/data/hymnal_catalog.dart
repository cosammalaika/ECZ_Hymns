import 'package:flutter/material.dart';

class HymnalCollection {
  final String fileName;
  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData icon;
  final bool isAvailable;

  const HymnalCollection({
    required this.fileName,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.icon,
    this.isAvailable = true,
  });
}

const List<HymnalCollection> hymnals = <HymnalCollection>[
  HymnalCollection(
    fileName: 'hymns',
    title: 'English',
    subtitle: 'Hymns Alive',
    accentColor: Color(0xFF0D4C63),
    icon: Icons.auto_stories_rounded,
  ),
  HymnalCollection(
    fileName: 'kaonde',
    title: 'Kaonde',
    subtitle: 'Nyimbo Ya Kutota Lesa',
    accentColor: Color(0xFF4E7A94),
    icon: Icons.menu_book_rounded,
  ),
  HymnalCollection(
    fileName: 'lunda',
    title: 'Lunda',
    subtitle: 'Tumina',
    accentColor: Color(0xFF7A8F4C),
    icon: Icons.library_music_rounded,
    isAvailable: false,
  ),
  HymnalCollection(
    fileName: 'luvale',
    title: 'Luvale',
    subtitle: 'Myaso Yakulemesa Kalunga',
    accentColor: Color(0xFFB8894D),
    icon: Icons.import_contacts_rounded,
    isAvailable: false,
  ),
  HymnalCollection(
    fileName: 'bemba',
    title: 'Bemba',
    subtitle: 'Inyimbo sha bwinakristu',
    accentColor: Color(0xFF6E78AD),
    icon: Icons.bookmarks_rounded,
  ),
  HymnalCollection(
    fileName: 'chewa',
    title: 'Chewa',
    subtitle: 'Nyimbo Za Mulungu',
    accentColor: Color(0xFF8B6D9C),
    icon: Icons.collections_bookmark_rounded,
  ),
  HymnalCollection(
    fileName: 'lozi',
    title: 'Lozi',
    subtitle: 'Kreste Mwa Lipina',
    accentColor: Color(0xFF4C8E79),
    icon: Icons.notes_rounded,
  ),
];

HymnalCollection hymnalCollectionForFile(String fileName) {
  return hymnals.firstWhere(
    (collection) => collection.fileName == fileName,
    orElse: () => hymnals.first,
  );
}
