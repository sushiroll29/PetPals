import 'package:fl/constants.dart';
import 'package:flutter/material.dart';

class DescriptionContainer extends StatelessWidget {
  final Widget child;

  const DescriptionContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      height: size.height * 0.2,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
