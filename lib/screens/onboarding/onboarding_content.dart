import 'package:fl/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key key,
    @required this.size,
    this.titleText,
    this.bodyText,
    this.image,
  }) : super(key: key);

  final Size size;
  final String titleText, bodyText, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    image,
                    height: size.height * 0.5,
                    width: size.width,
                  ),
                  Flexible(
                    child: Text(
                      titleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: aDarkGreyColor,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                                .fontFamily,
                        fontSize: size.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Flexible(
                    child: Text(
                      bodyText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: aDarkGreyColor,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.w400)
                                .fontFamily,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
