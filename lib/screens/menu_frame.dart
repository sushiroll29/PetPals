import 'package:fl/screens/home.dart';
import 'package:fl/screens/menu.dart';
import 'package:flutter/material.dart';

class MenuFrame extends StatefulWidget {
  @override
  _MenuFrameState createState() => _MenuFrameState();
}

class _MenuFrameState extends State<MenuFrame> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MenuPage(),
        HomePage(),
      ],
    );
  }
}
