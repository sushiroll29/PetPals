import 'package:fl/Pet.dart';
import 'package:flutter/material.dart';

class DetailedPet extends StatelessWidget {
  final Pet pet;

  DetailedPet({Key key, @required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
