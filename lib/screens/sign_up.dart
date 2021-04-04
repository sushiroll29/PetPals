import 'package:fl/components/existing_account_check.dart';
import 'package:fl/constants.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/screens/backgrounds/sign_up_bg.dart';
import 'package:fl/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fl/widgets/provider.dart';
import 'package:fl/components/text_field_container.dart';

//enum AuthFormType { signIn, signUp }

class SignUp extends StatefulWidget {
  //final AuthFormType authFormType;
/*
  SignUp({
    Key key, @required this.authFormType
  }) : super(key: key);
*/

  @override
  _SignUpState createState() => _SignUpState(//authFormType: this.authFormType
      );
}

class _SignUpState extends State<SignUp> {
  //AuthFormType authFormType;
  //_SignUpState({this.authFormType}); //instantiere

  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  String _error;

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        String uid =
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
        print("Signed up with ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
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
              //SizedBox(height: size.height * 0.005),
              showError(),
              SizedBox(height: size.height * 0.03), //1%
              AutoSizeText(
                'SIGN UP',
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 19,
                ),
              ),

              Image.asset(
                "assets/images/signup_doodle.png",
                height: size.width * 0.6,
              ),

              Form(
                key: formKey,
                child: Column(
                  children: inputsBuilder(),
                ),
              ),

              RoundedButton(
                  text: "CONTINUE",
                  press: () async {
                    submit();
                    //Navigator.of(context).pushReplacementNamed('/welcome');
                  }),
              SizedBox(height: size.height * 0.01),
              ExistingAccountCheck(
                login: false,
                press: () {
                  Navigator.of(context).pushReplacementNamed('/signIn');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showError() {
    if (_error != null) {
      return Container(
        color: aPrimaryLightColor,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Icon(Icons.error_outline_rounded),
              padding: EdgeInsets.only(right: 10.0),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.bold)
                      .fontFamily,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  List<Widget> inputsBuilder() {
    List<Widget> inputFields = [];

    inputFields.add(
      TextFieldContainer(
        child: TextFormField(
          onSaved: (value) => _name = value,
          validator: NameValidator.validate,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily:
                GoogleFonts.raleway(fontWeight: FontWeight.normal).fontFamily,
            height: 1.3,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily:
                  GoogleFonts.raleway(fontWeight: FontWeight.normal).fontFamily,
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(
              Icons.person_outline_rounded,
              size: 15.0,
              color: aPrimaryColor,
            ),
            border: InputBorder.none,
            hintText: "Name",
          ),
        ),
      ),
    );

    inputFields.add(
      TextFieldContainer(
        child: TextFormField(
          validator: EmailValidator.validate,
          onSaved: (value) => _email = value,
          style: GoogleFonts.raleway(fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily:
                  GoogleFonts.raleway(fontWeight: FontWeight.normal).fontFamily,
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(10.0),
            hintText: "Email",
            border: InputBorder.none,
            icon: Icon(
              Icons.alternate_email_rounded,
              color: aPrimaryColor,
            ),
          ),
        ),
      ),
    );
    inputFields.add(
      TextFieldContainer(
        child: TextFormField(
          validator: PasswordValidator.validate,
          obscureText: true,
          onSaved: (value) => _password = value,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily:
                GoogleFonts.raleway(fontWeight: FontWeight.normal).fontFamily,
            height: 1.3,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily:
                  GoogleFonts.raleway(fontWeight: FontWeight.normal).fontFamily,
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
