import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/screens/add_new_pet.dart';
import 'package:fl/screens/updated_detailed_pet.dart';
import 'package:fl/screens/home.dart';
import 'package:fl/screens/map.dart';
import 'package:fl/screens/new_pet/new_pet_type.dart';
import 'package:fl/screens/profile.dart';
import 'package:fl/screens/sign_out.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/provider.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedItemIndex = 0;
  int selectedBottomItemIndex = -1;

  List<String> bottomMenuItems = [
    'Settings',
    'Log out',
  ];

  List<IconData> bottomMenuIcons = [
    FontAwesomeIcons.cog,
    FontAwesomeIcons.signOutAlt,
  ];

  List<String> menuItems = [
    'Adoption',
    'Add pet',
    'Map',
    'Favorites',
    'Profile',
  ];

  List<IconData> menuIcons = [
    FontAwesomeIcons.paw,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.solidMap,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.userAlt,
  ];

  List<Widget> menuPages = [
    HomePage(),
    AddNewPetPage(),
    MapPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  List<Widget> bottomMenuPages = [
    //SettingsPage(),
    HomePage(),
    SignOutPage(),
  ];

  Widget buildMenuList(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menuPages[selectedItemIndex]),
        );
        setState(() {
          selectedItemIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              menuIcons[index],
              color: selectedItemIndex == index ? Colors.white : Colors.white38,
              size: 17,
            ),
            SizedBox(width: 15),
            Text(
              menuItems[index],
              style: TextStyle(
                fontSize: 20,
                color:
                    selectedItemIndex == index ? Colors.white : Colors.white38,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
              ),
            ),
            //Scaffold(
            //body: _children[selectedItemIndex],
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomMenuList(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => bottomMenuPages[selectedBottomItemIndex]),
        );
        setState(() {
          selectedBottomItemIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              bottomMenuIcons[index],
              color: Colors.white,
              size: 17,
            ),
            SizedBox(width: 15),
            Text(
              bottomMenuItems[index],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          "Ale Surdu",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold)
                                .fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: menuItems
                        .asMap()
                        .entries
                        .map((e) => buildMenuList(e.key))
                        .toList(),
                  ),
                  Column(
                    children: bottomMenuItems
                        .asMap()
                        .entries
                        .map((e) => buildBottomMenuList(e.key))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [aPrimaryStartingColor, aPrimaryColor],
          )),
        ),
      ),
    );
  }
}
