import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl/User.dart';
import 'package:fl/components/announcement_container.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/widgets/provider.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User("");
  TextEditingController _userPhoneNumberController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getUserData();
      _getProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          leading: IconButton(
            color: Colors.grey.shade400,
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      alignment: Alignment.center,
                      image: AssetImage('assets/images/profile_doodle.png'),
                      height: size.width * 0.65,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return displayUserInformation(context, snapshot);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${authData.displayName ?? 'null'}",
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                  .fontFamily,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email ?? 'Anonymous'}",
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                  .fontFamily,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Account created on ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                  .fontFamily,
            ),
          ),
        ),
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Phone number: ${_userPhoneNumberController.text}",
                        style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                          fontFamily: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.normal)
                              .fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        RoundedButton(
          text: "EDIT PHONE NUMBER",
          press: () {
            _userEditBottomSheet(context);
          },
        )
      ],
    );
  }

  _getPetData() async {
    //DocumentSnapshot document =
    Firestore.instance.collection('petsStream').getDocuments().then((data) {
      if (data.documents.isNotEmpty) {
        for (int i = 0; i < data.documents.length; i++) {
          if (data.documents[i].data['userId'] == _user.uid) {
            print("a");
            setState(() {});
          }
        }
      }
    });
  }

  // Future updatePet(context) async {
  //   var uuid = await Provider.of(context).auth.getCurrentUID();
  //   final doc = Firestore.instance
  //       .collection('petsStream')
  //       .document(widget.pet.documentId);

  //   return await doc.setData(widget.pet.toJson());
  // }

  FirebaseUser _user;
  Future<void> _getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      _user = userData;

      // print(_user.uid);
    });
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get()
        .then((result) {
      user.phoneNumber = result.data['phoneNumber'];
      _userPhoneNumberController.text = user.phoneNumber;
    });
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(25.0),
        topRight: const Radius.circular(25.0),
      )),
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Update phone number",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.normal)
                                .fontFamily,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.timesCircle,
                              color: Colors.grey.shade800, size: 20),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: TextFieldContainer(
                              child: TextFormField(
                                autocorrect: false,
                                autofocus: true,
                                textAlign: TextAlign.left,
                                controller: _userPhoneNumberController,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.normal)
                                      .fontFamily,
                                  height: 1.3,
                                ),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.normal)
                                        .fontFamily,
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                  hintText: "e.g. +40722222222",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundedButton(
                          text: 'SAVE',
                          press: () async {
                            user.phoneNumber = _userPhoneNumberController.text;
                            setState(() {
                              _userPhoneNumberController.text =
                                  user.phoneNumber;
                            });
                            final uid =
                                await Provider.of(context).auth.getCurrentUID();
                            await Provider.of(context)
                                .db
                                .collection('userData')
                                .document(uid)
                                .setData(user.toJson());

                            _getPetData();

                            //print(user.phoneNumber);

                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
