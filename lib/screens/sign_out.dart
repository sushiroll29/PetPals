import 'package:fl/screens/menu.dart';
import 'package:fl/screens/sign_in.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Are you sure you want to sign out?",
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                  fontFamily:
                      GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                          .fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                text: 'Yes',
                press: () async {
                  try {
                    AuthService auth = Provider.of(context).auth;
                    await auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                text: 'No',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
