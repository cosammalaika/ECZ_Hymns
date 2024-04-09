import 'package:flutter/material.dart';
import '../screen/about_screen.dart';
import '../screen/favorites_screen.dart';
import '../screen/hymn_list_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'ECZ Hymnals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          _buildVersionExpansionTile(context),
          _buildListTile(
            context,
            leadingIcon: Icons.favorite,
            title: 'Favorite',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          _buildListTile(
            context,
            leadingIcon: Icons.info,
            title: 'About',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVersionExpansionTile(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.language),
      title: const Text(
        'Hymnals',
        style: TextStyle(
          fontSize: 12, // Adjust the font size here
        ),
      ),
      children: [
        _buildDrawerItem(context, 'English', 'hymns'),
        _buildDrawerItem(context, 'Kaonde "Nyimbo Ya Kutota Lesa"', 'kaonde'),
        _buildDrawerItem(context, 'Lunda "Tumina"', 'lunda'),
        _buildDrawerItem(
            context, 'Luvale "Myaso Yakulemesa Kalunga"', 'luvale'),
        _buildDrawerItem(context, 'Bemba "Inyimbo sha bwinakristu"', 'bemba'),
        _buildDrawerItem(context, 'Chewa "Nyimbo Za Mulungu"', 'chewa'),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String fileName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: _buildListTile(
        context,
        leadingIcon: Icons.book,
        title: title,
        onTap: () {
          Navigator.pop(context); // Close the drawer
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HymnListScreen(fileName: fileName),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData leadingIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12, // Adjust the font size here
        ),
      ),
      onTap: onTap,
    );
  }
}
