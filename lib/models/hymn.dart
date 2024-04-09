// models/hymn.dart
class Hymn {
  final int id;
  final String title;
  final String author;
  final String meter;
  final String tuneName;
  final List<List<String>> verses;
  final List<String> chorus;
  final List<String> addedChorus;

  Hymn({
    required this.id,
    required this.title,
    required this.author,
    required this.meter,
    required this.tuneName,
    required this.verses,
    required this.chorus,
    required this.addedChorus,
  });

  factory Hymn.fromJson(Map<String, dynamic> json) {
    return Hymn(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      meter: json['meter'],
      tuneName: json['tuneName'],
      verses: List<List<String>>.from(json['verses'].map((v) => List<String>.from(v))),
      chorus: List<String>.from(json['chorus']),
      addedChorus: List<String>.from(json['addedChorus']),
    );
  }
}
