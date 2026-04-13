import 'package:flutter/material.dart';

class HymnalPalette {
  final Color primary;
  final Color primaryDeep;
  final Color accent;
  final Color accentSoft;
  final Color accentCool;
  final Color shadow;

  const HymnalPalette({
    required this.primary,
    required this.primaryDeep,
    required this.accent,
    required this.accentSoft,
    required this.accentCool,
    required this.shadow,
  });
}

class HymnalCollection {
  final String fileName;
  final String title;
  final String subtitle;
  final Color accentColor;
  final HymnalPalette palette;
  final IconData icon;
  final bool isAvailable;

  const HymnalCollection({
    required this.fileName,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.palette,
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
    palette: HymnalPalette(
      primary: Color(0xFF0D4C63),
      primaryDeep: Color(0xFF062F40),
      accent: Color(0xFFD1A04B),
      accentSoft: Color(0xFFF1E2BC),
      accentCool: Color(0xFFDDEAF2),
      shadow: Color(0x1C0D4C63),
    ),
    icon: Icons.auto_stories_rounded,
  ),
  HymnalCollection(
    fileName: 'kaonde',
    title: 'Kaonde',
    subtitle: 'Nyimbo Ya Kutota Lesa',
    accentColor: Color(0xFFB24A50),
    palette: HymnalPalette(
      primary: Color(0xFFB24A50),
      primaryDeep: Color(0xFF7A2F35),
      accent: Color(0xFFD29B57),
      accentSoft: Color(0xFFF2E0CC),
      accentCool: Color(0xFFF1E0E2),
      shadow: Color(0x1CB24A50),
    ),
    icon: Icons.menu_book_rounded,
  ),
  HymnalCollection(
    fileName: 'lunda',
    title: 'Lunda',
    subtitle: 'Tumina',
    accentColor: Color(0xFF68803D),
    palette: HymnalPalette(
      primary: Color(0xFF68803D),
      primaryDeep: Color(0xFF435227),
      accent: Color(0xFFC9A654),
      accentSoft: Color(0xFFEEE4BD),
      accentCool: Color(0xFFE2EBD8),
      shadow: Color(0x1C68803D),
    ),
    icon: Icons.library_music_rounded,
    // isAvailable: false,
  ),
  HymnalCollection(
    fileName: 'luvale',
    title: 'Luvale',
    subtitle: 'Myaso Yakulemesa Kalunga',
    accentColor: Color(0xFFA97334),
    palette: HymnalPalette(
      primary: Color(0xFFA97334),
      primaryDeep: Color(0xFF6F4A1D),
      accent: Color(0xFFD5A05C),
      accentSoft: Color(0xFFF1DEC2),
      accentCool: Color(0xFFEEE4D8),
      shadow: Color(0x1CA97334),
    ),
    icon: Icons.import_contacts_rounded,
  ),
  HymnalCollection(
    fileName: 'bemba',
    title: 'Bemba',
    subtitle: 'Inyimbo sha bwinakristu',
    accentColor: Color(0xFF5A69A0),
    palette: HymnalPalette(
      primary: Color(0xFF5A69A0),
      primaryDeep: Color(0xFF38446F),
      accent: Color(0xFFC9964C),
      accentSoft: Color(0xFFEEE0C0),
      accentCool: Color(0xFFE2E7F4),
      shadow: Color(0x1C5A69A0),
    ),
    icon: Icons.bookmarks_rounded,
  ),
  HymnalCollection(
    fileName: 'chewa',
    title: 'Chewa',
    subtitle: 'Nyimbo Za Mulungu',
    accentColor: Color(0xFF7C5E90),
    palette: HymnalPalette(
      primary: Color(0xFF7C5E90),
      primaryDeep: Color(0xFF523B63),
      accent: Color(0xFFC89C53),
      accentSoft: Color(0xFFF0E0C4),
      accentCool: Color(0xFFE7DFF0),
      shadow: Color(0x1C7C5E90),
    ),
    icon: Icons.collections_bookmark_rounded,
  ),
  HymnalCollection(
    fileName: 'lozi',
    title: 'Lozi',
    subtitle: 'Kreste Mwa Lipina',
    accentColor: Color(0xFF3F7E69),
    palette: HymnalPalette(
      primary: Color(0xFF3F7E69),
      primaryDeep: Color(0xFF275543),
      accent: Color(0xFFC8A151),
      accentSoft: Color(0xFFEEE4BE),
      accentCool: Color(0xFFDCEBE5),
      shadow: Color(0x1C3F7E69),
    ),
    icon: Icons.notes_rounded,
  ),
];

HymnalCollection hymnalCollectionForFile(String fileName) {
  return hymnals.firstWhere(
    (collection) => collection.fileName == fileName,
    orElse: () => hymnals.first,
  );
}
