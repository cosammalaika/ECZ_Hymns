import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/hymn.dart';

class DatabaseHelper {
  Future<List<Hymn>> getHymnsFromJson(String fileName) async {
    // Load JSON data from the assets folder based on the provided fileName
    String jsonString = await rootBundle.loadString('assets/$fileName.json');

    // Parse JSON data into List of Hymn objects
    List<dynamic> jsonList = json.decode(jsonString);
    List<Hymn> hymnsList = jsonList.map((json) => Hymn.fromJson(json)).toList();

    // Check if hymnsList is empty
    if (hymnsList.isEmpty) {
      return Future.error('No hymn found. Coming soon!');
    }

    return hymnsList;
  }
}
