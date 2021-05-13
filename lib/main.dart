import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/screens/menu.dart';
import 'package:fl/screens/menu_items/home.dart';
import 'package:fl/screens/authentication/password_reset.dart';
import 'package:fl/screens/authentication/sign_in.dart';
import 'package:fl/screens/authentication/sign_up.dart';
import 'package:fl/screens/menu_items/my_pets.dart';
import 'package:fl/screens/onboarding/onboarding.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/services/provider.dart';
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
          return signedIn ? HomePage() : Onboarding();
        }
        return Container();
      },
    );
  }
}
