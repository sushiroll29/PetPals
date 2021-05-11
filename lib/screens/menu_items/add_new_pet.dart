import 'package:fl/models/Pet.dart';
import 'package:fl/screens/new_pet/new_pet_type.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewPetPage extends StatefulWidget {
  final Function onMenuTap;

  AddNewPetPage({this.onMenuTap});

  @override
  _AddNewPetPageState createState() => _AddNewPetPageState();
}

class _AddNewPetPageState extends State<AddNewPetPage> {
  final newPet = new Pet(null, null, null, null, null, null, null, null, null,
      null, null, null, null, null, null, null, null, null, null);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
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
          padding: EdgeInsets.only(right: 22.0, left: 22.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 10),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/adoption_screen_doodle.png'),
                          height: size.width * 0.6,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Did you find a pet you wish to put up for adoption? Do you have a pet you can no longer care for?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.normal)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "We'll help you set up an adoption announcement!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.normal)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundedButton(
                              text: 'CONTINUE',
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewPetTypePage(pet: newPet)),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
