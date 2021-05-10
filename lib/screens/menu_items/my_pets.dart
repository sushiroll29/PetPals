import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl/widgets/constants.dart';
import 'package:fl/screens/menu_items/my_pets_detailed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/models/Pet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPetsPage extends StatefulWidget {
  // final Pet pet;
  // MyPetsPage({Key key, this.pet}) : super(key: key);
  @override
  _MyPetsPageState createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  Stream<QuerySnapshot> getMyPets(BuildContext context) async* {
    //final _uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection("petsStream")
        //.document()
        //.collection("pets")
        .orderBy('postDate', descending: true)
        .snapshots();
  }

  FirebaseUser user;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;

      //print(userData.uid);
    });
  }

  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            title: Text(
              'Your pets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                    .fontFamily,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(FontAwesomeIcons.bars),
              onPressed: () {
                //popmaybe?????
                //Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/menu');
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: StreamBuilder(
                                stream: getMyPets(context),
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
                                            buildMyPetsList(context,
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

  Widget buildMyPetsList(BuildContext context, DocumentSnapshot document) {
    final pet = Pet.fromSnapshot(document);
    final FirebaseAuth auth = FirebaseAuth.instance;
    //final petType = pet.types();
    Size size = MediaQuery.of(context).size;
    if (pet.userId != user.uid) {
      return Container(height: 0);
    }
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyPetsDetailed(pet: pet)));
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
                            'Found on ${DateFormat('dd MMMM yyyy').format(pet.foundOn).toString()}',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "${pet.imageURL}",
                      //height: 190, width: size.width * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Image.network("${pet.imageURL}",
                //     height: 190, width: size.width * 0.4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
