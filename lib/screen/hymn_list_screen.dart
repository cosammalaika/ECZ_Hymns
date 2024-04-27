import 'package:flutter/services.dart';
import 'package:ecz_hynms/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/hymn.dart';
import 'about_screen.dart';
import 'hymn_detail_screen.dart';

class TextOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^\x00-\x7F]+'), '');
    return newText == newValue.text
        ? newValue
        : newValue.copyWith(text: newText);
  }
}

class HymnListScreen extends StatefulWidget {
  final String fileName;

  const HymnListScreen({Key? key, required this.fileName}) : super(key: key);

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
      _displayedHymns = _allHymns.where((hymn) {
        // Check if the search term matches either the ID or title of the hymn
        return hymn.id.toString().contains(searchTerm) ||
            hymn.title.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SizedBox(
              height: 25,
              child: Image.asset(
                'assets/icons/books.png',
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF004d73),
        title: const Row(
          children: [
            Text(
              'Hymns',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              ' Alive',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              height: 25,
              child: Image.asset(
                'assets/icons/info.png',
              ),
            ),
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
                color: const Color(0xFFe6edf1),
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
                      size: 16,
                      color: Color(0xFF000046),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        inputFormatters: [TextOnlyInputFormatter()],
                        decoration: const InputDecoration(
                          hintText: 'Search ...',
                          border: InputBorder.none,
                        ),
                        onChanged: _searchHymns,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFe6edf1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _displayedHymns.length,
                        itemBuilder: (context, index) {
                          final hymn = _displayedHymns[index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFd7dcde),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                '${hymn.id}. ${hymn.title}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF000046),
                                ),
                              ),
                              onTap: () async {
                                final resetDisplayedHymns =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HymnDetailScreen(hymn: hymn),
                                  ),
                                );

                                if (resetDisplayedHymns == true) {
                                  setState(
                                    () {
                                      _displayedHymns = _allHymns;
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
