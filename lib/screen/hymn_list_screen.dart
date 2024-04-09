import 'package:ecz_hynms/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../database/hymn_search.dart';
import '../database/hymn_search_delegate.dart';
import '../models/hymn.dart';
import 'hymn_detail_screen.dart';

class HymnListScreen extends StatefulWidget {
  final String fileName;

  HymnListScreen({required this.fileName});

  @override
  _HymnListScreenState createState() => _HymnListScreenState();
}

class _HymnListScreenState extends State<HymnListScreen> {
  List<Hymn> _allHymns = [];
  List<Hymn> _displayedHymns = [];

  @override
  void initState() {
    super.initState();
    _loadHymns(widget.fileName);
  }

  Future<void> _loadHymns(String fileName) async {
    final hymns = await DatabaseHelper().getHymnsFromJson(fileName);
    setState(() {
      _allHymns = hymns;
      _displayedHymns = hymns;
    });
  }

  void _searchHymns(String searchTerm) {
    setState(() {
      _displayedHymns = HymnSearch.searchByTitle(_allHymns, searchTerm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ECZ Hymns'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final searchTerm = await showSearch(
                context: context,
                delegate: HymnSearchDelegate(_allHymns),
              );
              if (searchTerm != null) {
                _searchHymns(searchTerm);
              }
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     // Navigate to settings screen
          //   },
          // ),
        ],
      ),
      drawer: const MyDrawer(),
      body: _displayedHymns.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _displayedHymns.length,
              itemBuilder: (context, index) {
                final hymn = _displayedHymns[index];
                return ListTile(
                  title: Text('${hymn.id}. ${hymn.title}'),
                  onTap: () async {
                    final resetDisplayedHymns = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HymnDetailScreen(hymn: hymn),
                      ),
                    );

                    if (resetDisplayedHymns == true) {
                      setState(() {
                        _displayedHymns = _allHymns;
                      });
                    }
                  },
                );
              },
            ),
    );
  }
}
