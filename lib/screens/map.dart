import 'package:fl/constants.dart';
import 'package:fl/home_widgets.dart';
import 'package:fl/pages.dart';
import 'package:fl/screens/updated_detailed_pet.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/trash/old_home_trash.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/provider.dart';

class MapPage extends StatefulWidget {
  final Pet pet;
  MapPage({Key key, this.pet}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//Pet pet = new Pet();
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(
          title: specify['name'],
          snippet: specify['type'],
          onTap: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => UpdatedDetailedPet(pet: Pet('type', 'name', 'breed', 'gender', 'isVaccinated', 'isSterilised', 'location', 'age', )))));
          }),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  LatLng currentPostion;

  void getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  getMarkerData() async {
    Firestore.instance.collection('petsStream').getDocuments().then((data) {
      if (data.documents.isNotEmpty) {
        for (int i = 0; i < data.documents.length; i++) {
          initMarker(data.documents[i].data, data.documents[i].documentID);
        }
      }
    });
  }

  void initState() {
    getMarkerData();
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Find pets around you!',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                  .fontFamily,
            ),
          ),
          backgroundColor: aPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            myController = controller;
          },
          initialCameraPosition: CameraPosition(
              target: currentPostion,
              //target: LatLng(45.7494, 21.2272),
              zoom: 15),
        ));
  }
}
