import 'package:flutter/material.dart';
import '../screen/hymn_list_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFe6edf1), // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF004d73),
              ),
              child: Text(
                'Hymnals',
                style: TextStyle(
                  color: Color(0xFFe6edf1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              'English "Hymns Alive"',
              'hymns',
              'assets/icons/book (2).png',
            ),
            _buildDrawerItem(
              context,
              'Kaonde "Nyimbo Ya Kutota Lesa"',
              'kaonde',
              'assets/icons/book (1).png',
            ),
            _buildDrawerItem(
              context,
              'Lunda "Tumina"',
              'lunda',
              'assets/icons/book (3).png',
            ),
            _buildDrawerItem(
              context,
              'Luvale "Myaso Yakulemesa Kalunga"',
              'luvale',
              'assets/icons/book (4).png',
            ),
            _buildDrawerItem(
              context,
              'Bemba "Inyimbo sha bwinakristu"',
              'bemba',
              'assets/icons/book (5).png',
            ),
            _buildDrawerItem(
              context,
              'Chewa "Nyimbo Za Mulungu"',
              'chewa',
              'assets/icons/book (6).png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, String title, String fileName, String iconAsset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        color: const Color(0xFFe6edf1), // Background color
        child: _buildListTile(
          context,
          leadingIcon: SizedBox(
            height: 25,
            child: Image.asset(
              iconAsset,
            ),
          ),
          title: title,
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
    required Widget leadingIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: leadingIcon,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF000046),
        ),
      ),
      onTap: onTap,
    );
  }
}
