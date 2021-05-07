import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/home_widgets.dart';
import 'package:fl/screens/home_mock.dart';
import 'package:fl/screens/menu.dart';

import 'package:fl/screens/home.dart';
import 'package:fl/screens/my_pets.dart';
import 'package:fl/screens/password_reset.dart';
import 'package:fl/screens/sign_in.dart';
import 'package:fl/screens/sign_up.dart';
import 'package:fl/screens/welcome.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      db: Firestore.instance,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeController(),
          theme: ThemeData(
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) =>
                SignUp(//authFormType: AuthFormType.signUp
                    ),
            '/signIn': (BuildContext context) =>
                SignIn(//authFormType: AuthFormType.signIn
                    ),
            '/home': (BuildContext context) => HomeController(),
            '/welcome': (BuildContext context) =>
                Welcome(//authFormType: AuthFormType.signUp
                    ),
            '/passwordReset': (BuildContext context) =>
                PasswordReset(//authFormType: AuthFormType.signIn
                    ),
            '/myPets': (BuildContext context) => MyPetsPage(),
            '/menu': (BuildContext context) => MenuPage(),
          }),
    );
  }
}

//controls if the app shows home or welcome page
class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          //check if data is sending
          final bool signedIn = snapshot
              .hasData; //if not, it means that there's no user id => not signed in
          return signedIn ? HomePage() : Welcome();
        }
        return Container();
      },
    );
  }
}
