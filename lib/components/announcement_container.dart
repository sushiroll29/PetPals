import 'package:fl/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: aPrimaryLightColor.withOpacity(0.1),
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
