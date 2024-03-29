import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl/models/User.dart';
import 'package:fl/components/announcement_container.dart';
import 'package:fl/screens/new_pet/new_pet_summary.dart';
import 'package:fl/services/provider.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetPhonePage extends StatefulWidget {
  final Pet pet;
  NewPetPhonePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetPhonePageState createState() => _NewPetPhonePageState();
}

class _NewPetPhonePageState extends State<NewPetPhonePage> {
  FirebaseUser user;
  bool isUserLoading = true;
  User _user = User("");
  Future<void> getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
    //print(user.phoneNumber);
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get()
        .then((result) {
      //print(result.data['phoneNumber']);
      _user.phoneNumber = result.data['phoneNumber'];
      _phoneNumberController.text = _user.phoneNumber;
      //print(_phoneNumberController.text);
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _getProfileData();
    });
    super.initState();
  }

  TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _phoneNumberController.text = widget.pet.userPhoneNumber;

    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              leading: IconButton(
                color: Colors.grey.shade400,
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(right: 22.0, left: 22.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 90),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Please provide your phone number or update it if necessary.",
                                    textAlign: TextAlign.center,
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
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: TextFieldContainer(
                                    child: TextFormField(
                                      autocorrect: false,
                                      textAlign: TextAlign.left,
                                      controller: _phoneNumberController,
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
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundedButton(
                                    text: 'CONTINUE',
                                    press: () async {
                                      widget.pet.userPhoneNumber =
                                          _phoneNumberController.text;
                                      _user.phoneNumber =
                                          _phoneNumberController.text;

                                      final uid = await Provider.of(context)
                                          .auth
                                          .getCurrentUID();
                                      await Provider.of(context)
                                          .db
                                          .collection('userData')
                                          .document(uid)
                                          .setData(_user.toJson());

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewPetSummaryPage(
                                                      pet: widget.pet)));
                                    }),
                              ],
                            ),
                          ],
                        ),
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
}
