import 'package:flutter/material.dart';
import 'package:fl/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = aPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.7,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              fontFamily:
                  GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
