import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl/screens/menu_items/profile.dart';
import 'package:fl/widgets/constants.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/screens/menu_items/detailed_pet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/models/Pet.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  FirebaseUser user;
  String loggedUserName;
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      loggedUserName = user.displayName.toString();
    });
  }

  Future resultsLoaded;
  List _allResults = [];
  List _searchResults = [];
  List _dogResults = [];
  List _catResults = [];
  List _parrotResults = [];

  @override
  void initState() {
    super.initState();
    getUserData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPets();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      //if we have a search parameter
      for (var petSnapshot in _allResults) {
        var name = Pet.fromSnapshot(petSnapshot).name.toLowerCase();
        var type = Pet.fromSnapshot(petSnapshot).type.toLowerCase();
        var gender = Pet.fromSnapshot(petSnapshot).gender.toLowerCase();
        //search by name/pet type/gender
        if (type.contains(_searchController.text.toLowerCase()) ||
                name.contains(_searchController.text.toLowerCase()) ||
                gender == _searchController.text.toLowerCase()
            //gender.contains(_searchController.text.toLowerCase())
            ) {
          showResults.add(petSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _searchResults = showResults;
    });
  }

  petResultList() {
    var showDogResults = [];
    var showCatResults = [];
    var showParrotRestults = [];

    for (var petSnapshot in _allResults) {
      var type = Pet.fromSnapshot(petSnapshot).type.toLowerCase();
      if (type == "dog") {
        showDogResults.add(petSnapshot);
      } else if (type == "cat") {
        showCatResults.add(petSnapshot);
      } else if (type == "parrot") {
        showParrotRestults.add(petSnapshot);
      }

      setState(() {
        _dogResults = showDogResults;
        _catResults = showCatResults;
        _parrotResults = showParrotRestults;
      });
    }
  }

  int selectedPetIndex = -1;
  List<String> petTypes = ['Dogs', 'Cats', 'Parrots'];

  List<IconData> petIcons = [
    FontAwesomeIcons.dog,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.feather,
  ];

  getUsersPets() async {
    var data = await Firestore.instance
        .collection("petsStream")
        .orderBy('postDate', descending: true)
        .getDocuments();
    setState(() {
      _allResults = data.documents;
    });
    searchResultsList();
    petResultList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final pet = Pet.fromSnapshot(document);
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Text(
                                "$loggedUserName",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade700,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w600)
                                      .fontFamily,
                                ),
                              ),
                              // SizedBox(width: 10),
                              // RawMaterialButton(
                              //   onPressed: () {},
                              //   elevation: 2.0,
                              //   fillColor: Colors.white,
                              //   //padding: EdgeInsets.all(15.0),
                              //   shape: CircleBorder(),
                              //   //backgroundColor: Colors.blue,
                              //   child: ImageIcon(
                              //       AssetImage("assets/images/bg.jpg")),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                    controller: _searchController,
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

                          Container(
                            height: size.height * 0.12,
                            child: ListView.builder(
                              //padding: EdgeInsets.only(left: 30),
                              scrollDirection: Axis.horizontal,
                              itemCount: petTypes.length,
                              itemBuilder: (context, index) {
                                return buildPetIconList(index);
                              },
                            ),
                          ),
                          //*/
                          Expanded(
                            child: isSearchUsed(),
                            // ListView.builder(
                            //   itemCount: _searchResults.length,
                            //   itemBuilder: (BuildContext context, int index) =>
                            //       buildPetsList(context, _searchResults[index]),
                            // ),
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
              if (selectedPetIndex == -1)
                setState(() {
                  selectedPetIndex = index;
                });
              else if (selectedPetIndex == 0 ||
                  selectedPetIndex == 1 ||
                  selectedPetIndex == 2) {
                setState(() {
                  selectedPetIndex = -1;
                });
              }
            },
            child: Material(
              color: selectedPetIndex == index ? aPrimaryColor : Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 11.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                petTypes[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade400,
                  fontFamily:
                      GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                          .fontFamily,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPetsList(BuildContext context, DocumentSnapshot document) {
    final pet = Pet.fromSnapshot(document);
    //final petType = pet.types();
    Size size = MediaQuery.of(context).size;
    if (pet.userId == user.uid) {
      return Container(
        height: 0,
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailedPet(pet: pet)));
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

  Widget isSearchUsed() {
    if (selectedPetIndex == 0)
      return ListView.builder(
        itemCount: _dogResults.length,
        itemBuilder: (BuildContext context, int index) =>
            buildPetsList(context, _dogResults[index]),
      );
    else if (selectedPetIndex == 1)
      return ListView.builder(
        itemCount: _catResults.length,
        itemBuilder: (BuildContext context, int index) =>
            buildPetsList(context, _catResults[index]),
      );
    else if (selectedPetIndex == 2)
      return ListView.builder(
        itemCount: _parrotResults.length,
        itemBuilder: (BuildContext context, int index) =>
            buildPetsList(context, _parrotResults[index]),
      );
    else
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) =>
            buildPetsList(context, _searchResults[index]),
      );
  }
}
