import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            title: Text(
              'Credits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                    .fontFamily,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(FontAwesomeIcons.bars),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: <Widget>[
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: 'All illustrations used in this app are from ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                    ),
                    new TextSpan(
                      text: 'Freepik Storyset',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://storyset.com');
                        },
                    ),
                    new TextSpan(
                      text: '.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: 'Icon made by ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                    ),
                    new TextSpan(
                      text: 'photo3idea_studio ',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://www.flaticon.com/authors/photo3idea-studio');
                        },
                    ),
                    new TextSpan(
                      text: 'on ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                    ),
                    new TextSpan(
                      text: 'www.flaticon.com',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.flaticon.com');
                        },
                    ),
                    new TextSpan(
                      text: '. (also used on splashscreen).',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                .fontFamily,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
