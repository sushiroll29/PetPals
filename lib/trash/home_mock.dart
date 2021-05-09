import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl/components/text_field_container.dart';
import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/screens/updated_detailed_pet.dart';
import 'package:fl/screens/profile.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/provider.dart';

class HomeMockPage extends StatefulWidget {
  final Function onMenuTap;

  HomeMockPage({this.onMenuTap});

  @override
  _HomeMockPageState createState() => _HomeMockPageState();
}

class _HomeMockPageState extends State<HomeMockPage> {
  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      //print(userData.uid);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  int selectedPetIndex = 0;
  List<String> petTypes = [
    'Dogs',
    'Cats',
  ];

  List<IconData> petIcons = [
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
  ];
  Stream<QuerySnapshot> getUsersPets(BuildContext context) async* {
    final _uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection("petsStream")
        //.document()
        //.collection("pets")
        .orderBy('postDate', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final pet = Pet.fromSnapshot(document);
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(FontAwesomeIcons.bars),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets
              //symmetric(vertical: 50.0),
              .only(top: 20.0),
          child: Column(
            children: <Widget>[
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          //widget.onMenuTap();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuPage()),
                          );
                        },
                        child: Icon(FontAwesomeIcons.bars,
                            color: Colors.grey.shade400)),
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
              ),*/
              //SizedBox(height: size.height * 0.04),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.grey.shade300,
                                  size: 20,
                                ),
                                Expanded(
                                    child: TextField(
                                  //controller: _searchController,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontFamily: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.w600)
                                          .fontFamily,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'Search for a pet to adopt',
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600)
                                        .fontFamily,
                                    //height: 1.3,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),

                        //asta e pentru search
                        // Expanded(
                        //   child: ListView.builder(
                        //       itemCount: _allResults.length,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         buildPetsList(context, _allResults[index]);
                        //       }),
                        // ),

                        /*  partea astea nu stiu daca o mai includ
                        Container(
                          //color: Colors.blue,
                          height: size.height * 0.12,
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 30),
                            scrollDirection: Axis.horizontal,
                            itemCount: petTypes.length,
                            itemBuilder: (context, index) {
                              return buildPetIconList(index);
                            },
                          ),
                        ),*/
                        Expanded(
                            child: StreamBuilder(
                                stream: getUsersPets(context),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return Text(
                                      "Loading...",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontFamily: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.w600)
                                            .fontFamily,
                                      ),
                                    );

                                  return new ListView.builder(
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            buildPetsList(context,
                                                snapshot.data.documents[index]),
                                  );
                                }))
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

  Widget buildPetIconList(int index) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                selectedPetIndex = index;
              });
            },
            child: Material(
              color: selectedPetIndex == index ? aPrimaryColor : Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 11.0),
                child: Center(
                  child: Icon(
                    petIcons[index],
                    size: size.height * .035,
                    color: selectedPetIndex == index
                        ? Colors.white
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            petTypes[index],
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
              fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                  .fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPetsList(BuildContext context, DocumentSnapshot document) {
    final pet = Pet.fromSnapshot(document);
    final FirebaseAuth auth = FirebaseAuth.instance;
    //final petType = pet.types();
    Size size = MediaQuery.of(context).size;
    if (pet.userId == user.uid) {
      return Container(
        height: 0,
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatedDetailedPet(pet: pet)));
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 30,
            left: 20,
            right: 20,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 17.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: size.width * 0.4),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pet.name,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 18.5,
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.bold)
                                        .fontFamily,
                                  ),
                                ),
                                Icon(
                                    pet.gender == 'Male'
                                        ? FontAwesomeIcons.mars
                                        : FontAwesomeIcons.venus,
                                    color: Colors.grey.shade400),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Text(pet.type,),
                            Text(
                              '${pet.age} old',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Found on ${DateFormat('dd/MM/yyyy').format(pet.foundOn).toString()}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: aPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 190,
                    width: size.width * 0.4,
                  ),
                  Image(
                    image: AssetImage('assets/images/bg.jpg'),
                    height: 190,
                    width: size.width * 0.4,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}