import 'package:flutter/material.dart';
import 'package:game_app/pages/category/categories.dart';
import 'package:game_app/pages/feedback/feedback.dart';
import 'package:game_app/pages/help/help.dart';
import 'package:game_app/pages/settings/settings.dart';

import '../drawer/drawer_screen.dart';
import '../home/home_page.dart';

class PagesController extends StatefulWidget {
  const PagesController({Key? key}) : super(key: key);

  @override
  PagesState createState() => PagesState();
}

class PagesState extends State<PagesController> {
  String selectedRow = 'Games';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(
            key: drawerPageKey,
            onRowSelectionChanged: (newSelectedRow) {
              setState(() {
                selectedRow = newSelectedRow;
              });
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _buildSelectedPage(selectedRow),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPage(String selectedRow) {
    switch (selectedRow) {
      case 'Games':
        return const HomePage(
          key: PageStorageKey('Games'),
        );
      case 'Category':
        return const CategoryPage(
          key: PageStorageKey('Category'),
        );  
      
      case 'Feedback':
        return const FeedbackPage(
          key: PageStorageKey('Feedback'),
        );
      case 'Settings':
        return const SettingsPage(
          key: PageStorageKey('Settings'),
        );
      case 'Help':
        return const HelpPage(
          key: PageStorageKey('Help'),
        );
      default:
        return Container();
    }
  }
}
