import 'package:fl/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Drpdown extends StatefulWidget {
  const Drpdown({Key key}) : super(key: key);

  @override
  _DrpdownState createState() => _DrpdownState();
}

class _DrpdownState extends State<Drpdown> {
  String _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _genders = ["Male", "Female"];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      width: size.width * 0.78,
      height: 65,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                fillColor: Colors.red,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(29))),
            isEmpty: _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: new Text("  SELECT PET'S GENDER"),
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w500)
                      .fontFamily,
                  fontSize: 14,
                  color: aPrimaryColor,
                ),
                value: _currentSelectedValue,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedValue = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _genders.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
