import 'package:ecz_hynms/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../database/hymn_search.dart';
import '../models/hymn.dart';
import 'about_screen.dart';
import 'hymn_detail_screen.dart';

class HymnListScreen extends StatefulWidget {
  final String fileName;

  const HymnListScreen({super.key, required this.fileName});

  @override
  // ignore: library_private_types_in_public_api
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
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu_book_outlined,
              color: Color(0xFFeff3f9),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF000046),
        title: const Row(
          children: [
            Text(
              'Hymns',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFeff3f9),
              ),
            ),
            Text(
              ' Forgotten',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color(0xFFeff3f9),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded,
                color: Color(0xFFeff3f9)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFeff3f9),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Color(0xFF000046),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search ...',
                          border: InputBorder.none,
                        ),
                        onChanged: _searchHymns,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF000046),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _displayedHymns.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.computer,
                          size: 50,
                          color: Color(0xFF000046),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Coming soon",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF000046),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _displayedHymns.length,
                      itemBuilder: (context, index) {
                        final hymn = _displayedHymns[index];
                        return ListTile(
                          title: Text(
                            '${hymn.id}. ${hymn.title}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF000046),
                            ),
                          ),
                          onTap: () async {
                            final resetDisplayedHymns = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HymnDetailScreen(hymn: hymn),
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
                  ),
          ),
        ],
      ),
    );
  }
}
