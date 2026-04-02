import 'package:flutter/material.dart';

import 'data/hymnal_catalog.dart';
import 'database/database_helper.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_controller.dart';
import 'screen/hymn_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().warmUpCollections(
    hymnals
        .where((collection) => collection.isAvailable)
        .map((collection) => collection.fileName),
  );
  final ThemeModeController themeModeController =
      await ThemeModeController.create();
  runApp(HymnBookApp(themeModeController: themeModeController));
}

class HymnBookApp extends StatelessWidget {
  final ThemeModeController themeModeController;

  const HymnBookApp({
    super.key,
    required this.themeModeController,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeModeScope(
      controller: themeModeController,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeModeController,
        builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hymns Alive',
            theme: HymnsTheme.light(),
            darkTheme: HymnsTheme.dark(),
            themeMode: themeMode,
            home: const HymnListScreen(
              fileName: 'hymns',
            ),
          );
        },
      ),
    );
  }
}
