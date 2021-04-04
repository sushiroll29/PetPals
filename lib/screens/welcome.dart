import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/constants.dart';
import 'package:fl/widgets/rounded_button_light.dart';
import 'package:flutter/material.dart';
import 'package:fl/screens/backgrounds/welcome_bg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/widgets/rounded_button.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              "Saving a life will change your own.\nAdopt a pet today.",
              style: TextStyle(
                fontFamily:
                    GoogleFonts.raleway(fontWeight: FontWeight.w400).fontFamily,
                fontSize: 21,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              "assets/images/welcome_doodle.png",
              height: size.height * 0.3,
            ),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                Navigator.of(context).pushReplacementNamed('/signIn');
              },
            ),
            RoundedButtonLight(
              color: aPrimaryLightColor,
              textColor: Colors.black,
              text: "SIGN UP",
              press: () {
                Navigator.of(context).pushReplacementNamed('/signUp');

                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp(authFormType: AuthFormType.signUp);
                      
                    },
                  ),
                );*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
