import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/hymn.dart';

class DatabaseHelper {
  static final Map<String, List<Hymn>> _cache = <String, List<Hymn>>{};
  static final Map<String, Future<List<Hymn>>> _pendingLoads =
      <String, Future<List<Hymn>>>{};

  List<Hymn>? getCachedHymns(String fileName) => _cache[fileName];

  Future<List<Hymn>> getHymnsFromJson(String fileName) async {
    final List<Hymn>? cached = _cache[fileName];
    if (cached != null) {
      return cached;
    }

    final Future<List<Hymn>>? pending = _pendingLoads[fileName];
    if (pending != null) {
      return pending;
    }

    final Future<List<Hymn>> loadFuture = _loadAndCacheHymns(fileName);
    _pendingLoads[fileName] = loadFuture;

    try {
      return await loadFuture;
    } finally {
      _pendingLoads.remove(fileName);
    }
  }

  Future<void> warmUpCollections(Iterable<String> fileNames) async {
    await Future.wait<void>(
      fileNames.map((String fileName) async {
        try {
          await getHymnsFromJson(fileName);
        } catch (_) {
          // Leave unavailable or malformed hymnals out of the warm cache.
        }
      }),
    );
  }

  Future<List<Hymn>> _loadAndCacheHymns(String fileName) async {
    final String jsonString =
        await rootBundle.loadString('assets/json/$fileName.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    final List<Hymn> hymnsList = <Hymn>[];
    for (final dynamic item in jsonList) {
      if (item is! Map<String, dynamic>) {
        continue;
      }

      try {
        hymnsList.add(Hymn.fromJson(item));
      } catch (_) {
        // Skip malformed hymn rows so one bad entry does not block the collection.
      }
    }

    if (hymnsList.isEmpty) {
      return Future<List<Hymn>>.error('No hymn found. Coming soon!');
    }

    _cache[fileName] = hymnsList;
    return hymnsList;
  }
}
