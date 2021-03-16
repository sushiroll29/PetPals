import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/top_bubble1.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/bottom_bubble2.png",
                width: size.width * 0.25,
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
