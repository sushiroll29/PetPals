import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Locatie', snippet: specify['address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    Firestore.instance
        .collection('locations')
        .getDocuments()
        .then((myMockLocations) {
      if (myMockLocations.documents.isNotEmpty) {
        for (int i = 0; i < myMockLocations.documents.length; i++) {
          initMarker(myMockLocations.documents[i].data,
              myMockLocations.documents[i].documentID);
        }
      }
    });
  }

  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
          markerId: MarkerId('Locatie'),
          position: LatLng(45.751110, 21.266010),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'O locatie'),
        )
      ].toSet();
    }
*/
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
          initialCameraPosition:
              CameraPosition(target: LatLng(45.7494, 21.2272), zoom: 15),
        ));
  }
}
