import 'package:fl/Pet.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/screens/new_pet/new_pet_type.dart';
import 'package:fl/screens/sign_in.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewPetPage extends StatelessWidget {
  final newPet =
      new Pet(null, null, null, null, null, null, null, null, null, null);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/images/adoption_screen_doodle.png'),
                height: size.width * 0.6,
              ),
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
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.normal)
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
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.normal)
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
                          builder: (context) => NewPetTypePage(pet: newPet)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
