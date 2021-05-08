import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/map.dart';
import 'package:fl/screens/new_pet/new_pet_location.dart';
import 'package:fl/screens/new_pet/new_pet_profile.dart';
import 'package:fl/services/firebase_storage_service.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                    text: 'UPLOAD AN IMAGE',
                    press: () {
                      uploadImage();
                    }),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'CONTINUE',
                  press: () {
                    widget.pet.imageURL = _imageUrl;
                    print(_imageUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapScreen(pet: widget.pet)),
                      //PetImage o sa se duca la MapScreen
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//   pickImage() async {
//     PickedFile image;
//     final _picker = ImagePicker();

//     await Permission.photos.request();

//     var permissionStatus =
//         await Permission.photos.status; //check status of photos permissions

//     if (permissionStatus.isGranted) {
//       //get image from device
//       image = await _picker.getImage(source: ImageSource.gallery);
//     }
//     print(image.path);
//   }
// }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //check for permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
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
}

/*
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    !uploading ? chooseImage() : null),
                          )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                  }),
            ),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ],
        ));
  }

  

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).isComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }*/
