import 'package:fl/constants.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: aPrimaryColor,
        title: Text(""),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed out!");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }
}
