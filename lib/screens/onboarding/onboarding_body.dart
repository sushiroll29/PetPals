import 'package:fl/screens/authentication/sign_in.dart';
import 'package:fl/screens/onboarding/onboarding_content.dart';
import 'package:fl/widgets/constants.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int pageIndex = 0;
  List<Map<String, String>> onboardingData = [
    {
      "titleText": "Welcome to PetPals!",
      "bodyText": "Let's get started!",
      "image": "assets/images/doodle_1.png",
    },
    {
      "titleText": "Browse through pets",
      "bodyText":
          "See what types of animals are up for adoption at the moment.",
      "image": "assets/images/doodle_2.png",
    },
    {
      "titleText": "Look for pets in your area",
      "bodyText":
          "Open the map and see if there are any pets waiting to be adopted near you.",
      "image": "assets/images/doodle_5.png",
    },
    {
      "titleText": "Create your own adoption post",
      "bodyText":
          "Have a pet you wish to put up for adoption?\nSet up your own adoption announcement!",
      "image": "assets/images/doodle_4.png",
    }
  ];

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => OnboardingContent(
                    size: size,
                    titleText: onboardingData[index]["titleText"],
                    bodyText: onboardingData[index]["bodyText"],
                    image: onboardingData[index]["image"],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingData.length,
                        (index) => buildDot(index: index)),
                  ),
                  SizedBox(height: 15),
                  RoundedButton(
                      press: () {
                        if (pageIndex == onboardingData.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        } else {
                          _pageController.animateToPage(pageIndex + 1,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.ease);
                        }
                      },
                      text: pageIndex == onboardingData.length - 1
                          ? "CONTINUE"
                          : "NEXT"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.only(right: 8),
      height: 6,
      width: pageIndex == index ? 20 : 6,
      decoration: BoxDecoration(
          color: pageIndex == index ? aPrimaryColor : aLightGreyColor,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
