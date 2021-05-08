import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/Pet.dart';
import 'package:fl/constants.dart';
import 'package:fl/main.dart';
import 'package:fl/screens/home.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatedDetailedPet extends StatefulWidget {
  final Pet pet;

  UpdatedDetailedPet({Key key, @required this.pet}) : super(key: key);

  @override
  _UpdatedDetailedPetState createState() => _UpdatedDetailedPetState();
}

class _UpdatedDetailedPetState extends State<UpdatedDetailedPet> {
  Future<void> _launched;
  final db = Firestore.instance;
  bool isPressed = false;
  List<String> petDetails = [
    'Vaccinated: ',
    'Sterilised: ',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment(0, -0.25),
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                // alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: size.height * 0.4,
                    child: Image(
                      image: AssetImage('assets/images/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                color: Colors.grey.shade400,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 25, top: 90),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        /* !!!!!!!!!!!!!!! de adaugat metoda din notes pentru detalii sau direct din listview.builder
                        Row(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.only(left: 30),
                              scrollDirection: Axis.horizontal,
                              itemCount: petDetails.length,
                              itemBuilder: (context, index) {
                                //return buildPetDetailsList(index);
                              },
                            ),
                          ],
                        ),
                        */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  /////////////////!!!!!!!!!!! de schimbat cu displayName
                                  '${widget.pet.usersName}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.normal)
                                        .fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${DateFormat('dd MMMM yyyy').format(widget.pet.postDate).toString()}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${widget.pet.description}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.normal)
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: aLightGreyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(25),
                        elevation: 4,
                        color: aPrimaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.solidHeart,
                              color: (isPressed) ? Colors.red : Colors.white,
                            ),
                            onPressed: () async {
                              //saves to Favorites collection in Firebase
                              /*
                              final uid = await Provider.of(context)
                                  .auth
                                  .getCurrentUID();

                              await db
                                  .collection("userData")
                                  .document(uid)
                                  .collection("favorites")
                                  .add(widget.pet.toJson());
*/
                              setState(() {
                                //widget.pet.isFavorite = true;
                              });

                              await deletePet(context);
                              /*
                                final uid = await Provider.of(context)
                                    .auth
                                    .getCurrentUID();

                                await db
                                    .collection("userData")
                                    .document(uid)
                                    .collection("favorites")
                                    .add(widget.pet.toJson());
                                    */
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          elevation: 4,
                          color: aPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: FlatButton(
                              child: Text(
                                'Adopt me',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w700)
                                      .fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _launched = _makePhoneCall(
                                      'tel:${widget.pet.userPhoneNumber}');
                                });
                                //print("${widget.pet.userPhoneNumber}");
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.pet.name,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18.5,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold)
                                  .fontFamily,
                            ),
                          ),
                          Icon(
                              widget.pet.gender == 'Male'
                                  ? FontAwesomeIcons.mars
                                  : FontAwesomeIcons.venus,
                              color: Colors.grey.shade400),
                        ],
                      ),
                      SizedBox(height: 10),
                      //Text(pet.type,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.pet.breed}',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600)
                                  .fontFamily,
                            ),
                          ),
                          Text(
                            '${widget.pet.age} old',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600)
                                  .fontFamily,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Found on ${DateFormat('dd/MM/yyyy').format(widget.pet.foundOn).toString()}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontFamily:
                              GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                  .fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future deletePet(context) async {
    var uuid = await Provider.of(context).auth.getCurrentUID();

    final doc = Firestore.instance
        .collection('userData')
        .document(uuid)
        .collection('favorites')
        .document('0ui8SQ9f3G3wM7SuTQwr');

    return await doc.delete();
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
/*
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(''),
              backgroundColor: Colors.grey[300],
              expandedHeight: size.height * 0.35,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/bg.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 200.0,
              delegate: SliverChildListDelegate([
                Text(pet.name),
                Text(pet.name),
                Text(pet.name),
                Text(pet.name),
                Text(pet.name),
                Text(pet.gender),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
*/
