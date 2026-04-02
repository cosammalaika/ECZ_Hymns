import 'package:flutter/material.dart';

import '../data/hymnal_catalog.dart';
import '../database/database_helper.dart';
import '../models/hymn.dart';
import '../theme/app_theme.dart';
import '../widgets/hymns_ui.dart';
import 'about_screen.dart';
import 'hymn_detail_screen.dart';
import 'hymnal_selector_screen.dart';

class HymnListScreen extends StatefulWidget {
  final String fileName;

  const HymnListScreen({super.key, required this.fileName});

  @override
  _HymnListScreenState createState() => _HymnListScreenState();
}

class _HymnListScreenState extends State<HymnListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Hymn> _allHymns = [];
  List<Hymn> _displayedHymns = [];
  bool _isLoading = true;
  String? _errorMessage;
  late HymnalCollection _selectedCollection;

  @override
  void initState() {
    super.initState();
    _selectedCollection = hymnalCollectionForFile(widget.fileName);
    _loadHymns(_selectedCollection);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHymns(HymnalCollection collection) async {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final List<Hymn>? cachedHymns =
        databaseHelper.getCachedHymns(collection.fileName);

    if (cachedHymns != null) {
      setState(() {
        _selectedCollection = collection;
        _allHymns = cachedHymns;
        _displayedHymns =
            _filterHymns(_searchController.text, source: cachedHymns);
        _errorMessage = null;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _selectedCollection = collection;
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final hymns = await databaseHelper.getHymnsFromJson(collection.fileName);
      if (!mounted) {
        return;
      }

      setState(() {
        _allHymns = hymns;
        _displayedHymns = _filterHymns(_searchController.text, source: hymns);
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _allHymns = <Hymn>[];
        _displayedHymns = <Hymn>[];
        _errorMessage =
            'This hymnal is being prepared for a future release. Try another collection for now.';
        _isLoading = false;
      });
    }
  }

  List<Hymn> _filterHymns(String query, {List<Hymn>? source}) {
    final String normalizedQuery = query.trim().toLowerCase();
    final List<Hymn> data = source ?? _allHymns;

    if (normalizedQuery.isEmpty) {
      return data;
    }

    return data.where((Hymn hymn) {
      return hymn.id.toString().contains(normalizedQuery) ||
          hymn.title.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  void _searchHymns(String searchTerm) {
    setState(() {
      _displayedHymns = _filterHymns(searchTerm);
    });
  }

  Future<void> _openHymnalSelector() async {
    final String? selectedFileName = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (BuildContext context) => HymnalSelectorScreen(
          selectedFileName: _selectedCollection.fileName,
        ),
      ),
    );

    if (!mounted ||
        selectedFileName == null ||
        selectedFileName == _selectedCollection.fileName) {
      return;
    }

    _searchController.clear();
    await _loadHymns(hymnalCollectionForFile(selectedFileName));
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnsUiPalette ui = context.hymnsPalette;
    final HymnalPalette palette = _selectedCollection.palette;
    final double topContentInset =
        MediaQuery.of(context).padding.top + kToolbarHeight + 12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: _openHymnalSelector,
            icon: const Icon(Icons.menu_book_rounded),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AboutScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: HymnsPageBackground(
        primaryColor: palette.primary,
        accentColor: palette.accent,
        accentCoolColor: palette.accentCool,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20, topContentInset, 20, 32),
          children: <Widget>[
            _buildHeroHeader(context, textTheme),
            const SizedBox(height: 18),
            HymnsSurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: TextField(
                controller: _searchController,
                onChanged: _searchHymns,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'Search by hymn number or title',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            const SizedBox(height: 22),
            if (_isLoading)
              _buildStateCard(
                context,
                icon: Icons.auto_stories_rounded,
                title: 'Loading hymns',
                message: 'Preparing your offline collection.',
              )
            else if (_errorMessage != null)
              _buildStateCard(
                context,
                icon: Icons.hourglass_bottom_rounded,
                title: 'Collection unavailable',
                message: _errorMessage!,
              )
            else if (_displayedHymns.isEmpty)
              _buildStateCard(
                context,
                icon: Icons.search_off_rounded,
                title: 'No hymns found',
                message:
                    'Try a different hymn number, title, or switch to another hymnal.',
              )
            else
              ...List<Widget>.generate(
                _displayedHymns.length,
                (int index) {
                  final Hymn hymn = _displayedHymns[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == _displayedHymns.length - 1 ? 0 : 14,
                    ),
                    child: HymnsSurfaceCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => HymnDetailScreen(
                              hymn: hymn,
                              collection: _selectedCollection,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: _selectedCollection.accentColor
                                  .withOpacity(ui.isDark ? 0.24 : 0.16),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              hymn.id.toString(),
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: 16,
                                color: _selectedCollection.accentColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  hymn.title,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: palette.primaryDeep.withOpacity(0.55),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, TextTheme textTheme) {
    final HymnalPalette palette = _selectedCollection.palette;
    final HymnsUiPalette ui = context.hymnsPalette;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            palette.primary,
            palette.primaryDeep,
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette.shadow,
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(ui.isDark ? 0.16 : 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _selectedCollection.icon,
                  color: Colors.white.withOpacity(0.96),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _isLoading ? 'Loading...' : '${_allHymns.length} hymns',
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            _selectedCollection.title,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedCollection.subtitle,
            style: textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HymnalPalette palette = _selectedCollection.palette;
    final HymnsUiPalette ui = context.hymnsPalette;
    final Color stateIconBackground = ui.isDark
        ? Color.alphaBlend(palette.primary.withOpacity(0.24), ui.surfaceSecondary)
        : palette.accentCool;

    return HymnsSurfaceCard(
      child: Column(
        children: <Widget>[
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: stateIconBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: palette.primary,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
