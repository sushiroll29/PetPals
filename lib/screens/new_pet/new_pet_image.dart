import 'package:fl/screens/new_pet/new_pet_location.dart';
import 'package:fl/services/firebase_storage_service.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class PetImagePage extends StatefulWidget {
  final Pet pet;

  PetImagePage({Key key, @required this.pet}) : super(key: key);

  @override
  _PetImagePageState createState() => _PetImagePageState();
}

class _PetImagePageState extends State<PetImagePage> {
  String _imageUrl;
  var uuid = Uuid();
  final storageService = FirebaseStorageService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 22.0, left: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              'assets/images/uploadImage_doodle.png'),
                          height: size.width * 0.6,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Select an image of your pet.",
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
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                                text: 'OPEN CAMERA',
                                press: () async {
                                  await uploadCameraImage();
                                  if (_imageUrl != null) {
                                    print("uploaded");
                                    showSuccessAlertDialog(context);
                                  } else
                                    showFailAlertDialog(context);
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "or",
                              textAlign: TextAlign.center,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                                text: 'CHOOSE FROM GALLERY',
                                press: () async {
                                  await uploadGalleryImage();
                                  if (_imageUrl != null) {
                                    print("uploaded");
                                    showSuccessAlertDialog(context);
                                  } else
                                    showFailAlertDialog(context);
                                }),
                          ],
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
    );
  }

  uploadGalleryImage() async {
    final _picker = ImagePicker();
    PickedFile image;
    //check for permissions
    await Permission.photos.request();
    var permissionPhotoStatus = await Permission.photos.status;

    if (permissionPhotoStatus.isGranted) {
      //if (permissionCameraStatus.isGranted) {
      //select image
      image = await _picker.getImage(source: ImageSource.gallery);

      //upload to firebase storage
      if (image != null) {
        var imageUrl =
            await storageService.uploadPetImage(File(image.path), uuid.v4());

        _imageUrl = imageUrl;
      } else {
        print('no path received');
      }
    } else {
      print('grant permissions and try again');
    }
  }

  uploadCameraImage() async {
    final _picker = ImagePicker();
    PickedFile image;
    //check for permissions
    await Permission.camera.request();

    var permissionCameraStatus = await Permission.camera.status;

    if (permissionCameraStatus.isGranted) {
      //if (permissionCameraStatus.isGranted) {
      //select image
      image = await _picker.getImage(source: ImageSource.camera);

      //upload to firebase storage
      if (image != null) {
        var imageUrl =
            await storageService.uploadPetImage(File(image.path), uuid.v4());

        _imageUrl = imageUrl;
      } else {
        print('no path received');
      }
    } else {
      print('grant permissions and try again');
    }
  }

  showSuccessAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = RoundedButton(
      text: 'CONTINUE',
      press: () {
        widget.pet.imageURL = _imageUrl;
        print(_imageUrl);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen(pet: widget.pet)),
        );
      },
    );

    Widget goBackButton = RoundedButton(
      text: 'CHOOSE ANOTHER IMAGE',
      press: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Image.network(
        '$_imageUrl',
        width: 150,
        height: 150,
        fit: BoxFit.contain,
      ),
      //SizedBox(height: 5),
      // Text(
      //   "Your image has been uploaded.",
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     color: Colors.grey.shade700,
      //     fontFamily:
      //         GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
      //     fontSize: 16,
      //   ),
      // ),

      actions: [okButton, goBackButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFailAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = RoundedButton(
      text: 'OK',
      press: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: Text(
        "Please choose an image.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontFamily:
              GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
          fontSize: 16,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
