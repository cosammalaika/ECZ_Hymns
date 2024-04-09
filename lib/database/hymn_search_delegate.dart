import 'package:flutter/material.dart';
import '../database/hymn_search.dart';
import '../models/hymn.dart';
import '../screen/hymn_detail_screen.dart';

class HymnSearchDelegate extends SearchDelegate<String> {
  final List<Hymn> hymns;

  HymnSearchDelegate(this.hymns);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredHymns = HymnSearch.searchByTitle(hymns, query);
    return ListView(
      children: filteredHymns
          .map((hymn) => ListTile(
                title: Text('${hymn.id}. ${hymn.title}'),
                onTap: () {
                  close(context, hymn.title);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HymnDetailScreen(hymn: hymn),
                    ),
                  ).then((value) {
                    query = '';
                  });
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: HymnSearch.searchByTitle(hymns, query)
          .map((hymn) => ListTile(
                title: Text('${hymn.id}. ${hymn.title}'),
                onTap: () {
                  close(context, hymn.title);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HymnDetailScreen(hymn: hymn),
                    ),
                  ).then((value) {
                    query = '';
                  });
                },
              ))
          .toList(),
    );
  }
}
