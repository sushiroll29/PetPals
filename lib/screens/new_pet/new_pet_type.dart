import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/screens/new_pet/new_pet_profile.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetTypePage extends StatefulWidget {
  final Pet pet;

  NewPetTypePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetTypePageState createState() => _NewPetTypePageState();
}

class _NewPetTypePageState extends State<NewPetTypePage> {
  @override
  Widget build(BuildContext context) {
    final petTypes = widget.pet.bigTypes();
    var petKeys = petTypes.keys.toList();

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
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.2),
              AutoSizeText(
                "Please choose the pet type",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w700)
                      .fontFamily,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                primary: false,
                children: List.generate(petTypes.length, (index) {
                  return TextButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        petTypes[petKeys[index]],
                      ],
                    ),
                    onPressed: () async {
                      widget.pet.type = petKeys[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewPetNamePage(pet: widget.pet)),
                      );
                    },
                  );
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
