import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/screens/map.dart';
import 'package:fl/screens/new_pet/new_pet_profile.dart';
import 'package:fl/screens/new_pet/new_pet_type.dart';
import 'package:fl/screens/profile.dart';
import 'package:fl/screens/home.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Pet pet;
  final List<Widget> _children = [
    MenuPage(),
    FavoritesPage(),
    MapPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final newPet =
        new Pet(null, null, null, null, null, null, null, null, null, null);
    return Scaffold(
      /*
      appBar: AppBar(
        backgroundColor: aPrimaryColor,
        title: Text(""),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.plus, size: 18),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPetTypePage(pet: newPet)));
              }),
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt, size: 18),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed out!");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),*/
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        selectedIconTheme: IconThemeData(
          size: 24,
        ),
        selectedItemColor: aPrimaryColor,
        unselectedItemColor: Colors.grey.shade400,
        backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
        selectedLabelStyle: TextStyle(
          fontFamily:
              GoogleFonts.raleway(fontWeight: FontWeight.w600).fontFamily,
          decoration: TextDecoration.none,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily:
              GoogleFonts.raleway(fontWeight: FontWeight.w300).fontFamily,
          decoration: TextDecoration.none,
        ),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Home',
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                //CupertinoIcons.home,
                FontAwesomeIcons.home,
                size: size.width * 0.05,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Favorites',
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.solidHeart,
                size: size.width * 0.05,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Map',
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.solidMap,
                size: size.width * 0.05,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[100],
            label: 'Profile',
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.userAlt,
                size: size.width * 0.05,
              ),
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

/*
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: aPrimaryColor,
        title: Text(""),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed out!");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }*/
