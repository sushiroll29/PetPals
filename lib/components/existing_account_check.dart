import 'package:flutter/material.dart';
import 'package:fl/widgets/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ExistingAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const ExistingAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an account? " : "Already have an account? ",
          style: TextStyle(
            color: aDarkGreyColor.withOpacity(0.8),
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.normal).fontFamily,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up!" : "Sign In!",
            style: TextStyle(
              fontFamily:
                  GoogleFonts.quicksand(fontWeight: FontWeight.bold).fontFamily,
              color: aDarkGreyColor.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
