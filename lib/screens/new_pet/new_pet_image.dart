// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl/constants.dart';
// import 'package:fl/screens/new_pet/new_pet_profile.dart';
// import 'package:fl/widgets/rounded_button.dart';
// import 'package:flutter/material.dart';
// import 'package:fl/Pet.dart';
// import 'package:fl/widgets/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:fl/screens/backgrounds/add_pet_bg.dart';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart' as Path;

// class NewPetImagePage extends StatefulWidget {
//   final Pet pet;

//   NewPetImagePage({Key key, @required this.pet}) : super(key: key);

//   @override
//   _NewPetImagePageState createState() => _NewPetImagePageState();
// }

// class _NewPetImagePageState extends State<NewPetImagePage> {

// bool uploading = false;
//   double val = 0;
//   CollectionReference imgRef;
//   firebase_storage.StorageReference ref;

//   List<File> _image = [];
//   final picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     //TextEditingController _controller = new TextEditingController();
//     //_controller.text = pet.location;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: size.height * 0.08,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(1),
//           ),
//         ),
//         backgroundColor: aPrimaryColor,
//         centerTitle: true,
//         title: Text(
//           "ADD A NEW PET",
//           style: TextStyle(
//             fontFamily:
//                 GoogleFonts.raleway(fontWeight: FontWeight.w600).fontFamily,
//             fontSize: 19,
//           ),
//         ),
//         actions: [
//             FlatButton(
//                 onPressed: () {
//                   setState(() {
//                     uploading = true;
//                   });
//                   uploadFile().whenComplete(() => Navigator.of(context).pop());
//                 },
//                 child: Text(
//                   'upload',
//                   style: TextStyle(color: Colors.white),
//                 ))
//           ],
//         ),
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.all(4),
//               child: GridView.builder(
//                   itemCount: _image.length + 1,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3),
//                   itemBuilder: (context, index) {
//                     return index == 0
//                         ? Center(
//                             child: IconButton(
//                                 icon: Icon(Icons.add),
//                                 onPressed: () =>
//                                     !uploading ? chooseImage() : null),
//                           )
//                         : Container(
//                             margin: EdgeInsets.all(3),
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: FileImage(_image[index - 1]),
//                                     fit: BoxFit.cover)),
//                           );
//                   }),
//             ),
//             uploading
//                 ? Center(
//                     child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         child: Text(
//                           'uploading...',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       CircularProgressIndicator(
//                         value: val,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                       )
//                     ],
//                   ))
//                 : Container(),
//           ],
//         ));
//   }

//   chooseImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       _image.add(File(pickedFile?.path));
//     });
//     if (pickedFile.path == null) retrieveLostData();
//   }

//   Future<void> retrieveLostData() async {
//     final LostData response = await picker.getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         _image.add(File(response.file.path));
//       });
//     } else {
//       print(response.file);
//     }
//   }

//   Future uploadFile() async {
//     int i = 1;

//     for (var img in _image) {
//       setState(() {
//         val = i / _image.length;
//       });
//       ref = firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('images/${Path.basename(img.path)}');
//       await ref.putFile(img).isComplete(() async {
//         await ref.getDownloadURL().then((value) {
//           imgRef.add({'url': value});
//           i++;
//         });
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     imgRef = FirebaseFirestore.instance.collection('imageURLs');
//   }
// }
