import 'package:fl/components/existing_account_check.dart';
import 'package:fl/constants.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:fl/widgets/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/screens/backgrounds/sign_up_bg.dart';
import 'package:fl/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fl/components/text_field_container.dart';

//enum AuthFormType { signIn, signUp }

class SignIn extends StatefulWidget {
  //final AuthFormType authFormType;
/*
  SignUp({
    Key key, @required this.authFormType
  }) : super(key: key);
*/
  @override
  _SignInState createState() => _SignInState(//authFormType: this.authFormType
      );
}

class _SignInState extends State<SignIn> {
  //AuthFormType authFormType;
  //_SignUpState({this.authFormType}); //instantiere

  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void submit() async {
    final form = formKey.currentState;
    form.save();
    final auth = Provider.of(context).auth;
    String uid = await auth.signInWithEmailAndPassword(_email, _password);
    print("Signed in with ID $uid");
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        //child: SingleChildScrollView(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01), //1%
              AutoSizeText(
                'SIGN IN',
                style: TextStyle(
                  fontFamily: GoogleFonts.manjari(fontWeight: FontWeight.bold)
                      .fontFamily,
                  fontSize: 19,
                ),
              ),

              Image.asset(
                "assets/images/login_doodle.png",
                height: size.width * 0.6,
              ),

              Form(
                key: formKey,
                child: Column(
                  children: inputsBuilder(),
                ),
              ),

              RoundedButton(
                  text: "SIGN IN",
                  press: () async {
                    submit();
                    //Navigator.of(context).pushReplacementNamed('/home');
                  }),
              SizedBox(height: size.height * 0.01),
              ExistingAccountCheck(
                login: true,
                press: () {
                  Navigator.of(context).pushReplacementNamed('/signUp');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> inputsBuilder() {
    List<Widget> inputFields = [];
    inputFields.add(
      TextFieldContainer(
        child: TextFormField(
          onSaved: (value) => _email = value,
          style: GoogleFonts.manjari(fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily:
                  GoogleFonts.manjari(fontWeight: FontWeight.normal).fontFamily,
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(10.0),
            hintText: "Email",
            border: InputBorder.none,
            icon: Icon(
              Icons.person_outline_rounded,
              color: aPrimaryColor,
            ),
          ),
        ),
      ),
    );
    inputFields.add(
      TextFieldContainer(
        child: TextFormField(
          obscureText: true,
          onSaved: (value) => _password = value,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily:
                GoogleFonts.manjari(fontWeight: FontWeight.normal).fontFamily,
            height: 1.3,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily:
                  GoogleFonts.manjari(fontWeight: FontWeight.normal).fontFamily,
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(
              Icons.lock_outline_rounded,
              size: 15.0,
              color: aPrimaryColor,
            ),
            border: InputBorder.none,
            hintText: "Password",
          ),
        ),
      ),
    );

    return inputFields;
  }
}
