import '../models/hymn.dart';

class HymnSearch {
  static List<Hymn> searchByTitle(List<Hymn> hymns, String searchTerm) {
    return hymns
        .where((hymn) =>
            hymn.title.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }
}
