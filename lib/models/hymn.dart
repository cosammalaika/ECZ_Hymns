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
    return Hymn(
      id: json['id'],
      title: json['title'],
      verses: List<List<String>>.from(json['verses'].map((v) => List<String>.from(v))),
      chorus: List<String>.from(json['chorus']),
    );
  }
}
