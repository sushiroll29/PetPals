import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/components/text_field_container.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'package:fl/screens/new_pet/new_pet_date.dart';
import 'package:fl/screens/new_pet/new_pet_summary.dart';
import 'package:fl/widgets/drp.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class MapScreen extends StatefulWidget {
  final Pet pet;
  MapScreen({Key key, @required this.pet}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PickResult selectedPlace;
  /*static const _initialCameraPosition = CameraPosition(
    target: LatLng(45.7494, 21.2272),
    zoom: 13.5,
  );*/
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(1),
          ),
        ),
        backgroundColor: aPrimaryColor,
        centerTitle: true,
        title: Text(
          "ADD A NEW PET",
          style: TextStyle(
            fontFamily:
                GoogleFonts.raleway(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 19,
          ),
        ),
      ),
      body: PlacePicker(
          apiKey: "AIzaSyCID7zNDSX0ql3mqZ4fKWpLvk54G_Y-L8k",
          hintText: "Where is the pet located?",
          initialPosition: LatLng(45.7494, 21.2272),
          useCurrentLocation: true,
          onPlacePicked: (result) {
            setState(() {
              selectedPlace = result;
            });
            //widget.pet.location = selectedPlace;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPetDatePage(pet: widget.pet)));
          }

          /*
        selectedPlaceWidgetBuilder:
            (_, selectedPlace, state, isSearchBarFocused) {
          return isSearchBarFocused
              ? Container()
              // Use FloatingCard or just create your own Widget.
              : FloatingCard(
                  bottomPosition: MediaQuery.of(context).size.height * 0.05,
                  leftPosition: MediaQuery.of(context).size.width * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  borderRadius: BorderRadius.circular(12.0),
                  child: state == SearchingState.Searching
                      ? Center(child: CircularProgressIndicator())
                      : RaisedButton(
                          onPressed: () {
                            setState(() {
                              selectedPlace = selectedPlace;
                            });
                            widget.pet.location = selectedPlace;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewPetDatePage(pet: widget.pet)));
                          },
                        ),
                );
        },*/
          ),
    );
  }
}
