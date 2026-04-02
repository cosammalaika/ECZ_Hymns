import 'package:flutter/material.dart';

import 'data/hymnal_catalog.dart';
import 'database/database_helper.dart';
import 'theme/app_theme.dart';
import 'screen/hymn_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().warmUpCollections(
    hymnals
        .where((collection) => collection.isAvailable)
        .map((collection) => collection.fileName),
  );
  runApp(const HymnBookApp());
}

class HymnBookApp extends StatelessWidget {
  const HymnBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hymns Alive',
      theme: HymnsTheme.light(),
      darkTheme: HymnsTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HymnListScreen(
        fileName: 'hymns',
      ),
    );
  }
}
