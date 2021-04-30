import 'package:fl/widgets/provider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${user.email}",
            style: TextStyle(fontSize: 20),
          ),
        ),
/*
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
              user.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
        ),
*/
        showSignOut(context),
      ],
    );
  }

  Widget showSignOut(context) {
    return RaisedButton(
      child: Text("Sign Out"),
      onPressed: () async {
        try {
          await Provider.of(context).auth.signOut();
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
