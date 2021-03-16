import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:fl/screens/backgrounds/welcome_bg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:fl/widgets/rounded_button_light.dart';
import 'package:fl/constants.dart';
import 'package:fl/pages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    FavoritesPage(),
    MessagesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        selectedIconTheme: IconThemeData(
          size: 24,
        ),
        selectedItemColor: Color.fromRGBO(57, 81, 89, 1.0),
        unselectedItemColor: Color.fromRGBO(57, 81, 89, 0.6),
        backgroundColor: Color.fromRGBO(220, 222, 221, 1.0),
        selectedLabelStyle: TextStyle(
          fontFamily:
              GoogleFonts.manjari(fontWeight: FontWeight.w800).fontFamily,
          decoration: TextDecoration.none,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily:
              GoogleFonts.manjari(fontWeight: FontWeight.w300).fontFamily,
          decoration: TextDecoration.none,
        ),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Home',
            icon: new Icon(
              Icons.home_rounded,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Favorites',
            icon: new Icon(
              Icons.favorite_rounded,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Messages',
            icon: new Icon(
              Icons.messenger_rounded,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Profile',
            icon: new Icon(
              Icons.person_rounded,
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
