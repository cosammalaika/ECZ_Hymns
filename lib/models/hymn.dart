// models/hymn.dart
class Hymn {
  final int id;
  final String title;
  final List<List<String>> verses;
  final List<String> chorus;

  Hymn({
    required this.id,
    required this.title,
    required this.verses,
    required this.chorus,
  });

  factory Hymn.fromJson(Map<String, dynamic> json) {
    final int? id = _parseId(json['id']);
    final String title = (json['title'] ?? '').toString().trim();
    final List<List<String>> verses = _parseVerses(json['verses']);

    if (id == null || title.isEmpty || verses.isEmpty) {
      throw const FormatException('Invalid hymn payload.');
    }

    return Hymn(
      id: id,
      title: title,
      verses: verses,
      chorus: _parseLines(json['chorus']),
    );
  }

  static int? _parseId(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '');
  }

  static List<List<String>> _parseVerses(dynamic value) {
    if (value is! List) {
      return <List<String>>[];
    }

    final List<List<String>> parsedVerses = <List<String>>[];

    for (final dynamic verse in value) {
      final List<String> lines = _parseLines(verse);
      if (lines.isNotEmpty) {
        parsedVerses.add(lines);
      }
    }

    return parsedVerses;
  }

  static List<String> _parseLines(dynamic value) {
    if (value == null) {
      return <String>[];
    }

    if (value is String) {
      final String trimmed = value.trim();
      return trimmed.isEmpty ? <String>[] : <String>[trimmed];
    }

    if (value is List) {
      final List<String> lines = <String>[];

      for (final dynamic entry in value) {
        lines.addAll(_parseLines(entry));
      }

      return lines;
    }

    final String normalized = value.toString().trim();
    return normalized.isEmpty ? <String>[] : <String>[normalized];
  }
}
