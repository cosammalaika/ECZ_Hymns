import 'package:flutter/material.dart';
import '../screen/about_screen.dart';
import '../screen/favorites_screen.dart';
import '../screen/hymn_list_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFeff3f9), // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF072D44),
              ),
              child: Text(
                'Hymnals',
                style: TextStyle(
                  color: Color(0xFFeff3f9),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              'English',
              'hymns',
              const Color(0xFF123456),
            ),
            _buildDrawerItem(
              context,
              'Kaonde "Nyimbo Ya Kutota Lesa"',
              'kaonde',
              const Color(0xFFD3494E),
            ),
            _buildDrawerItem(
              context,
              'Lunda "Tumina"',
              'lunda',
              const Color(0xFF7BB274),
            ),
            _buildDrawerItem(
              context,
              'Luvale "Myaso Yakulemesa Kalunga"',
              'luvale',
              const Color(0xFFF0944D),
            ),
            _buildDrawerItem(
              context,
              'Bemba "Inyimbo sha bwinakristu"',
              'bemba',
              const Color(0xFF658CBB),
            ),
            _buildDrawerItem(
              context,
              'Chewa "Nyimbo Za Mulungu"',
              'chewa',
              const Color(0xFF9b533f),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, String title, String fileName, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        color: const Color(0xFFeff3f9), // Background color
        child: _buildListTile(
          context,
          leadingIcon: Icons.book,
          title: title,
          iconColor: iconColor,
          onTap: () {
            Navigator.pop(context); 
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HymnListScreen(fileName: fileName),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData leadingIcon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF072D44),
        ),
      ),
      onTap: onTap,
    );
  }
}
