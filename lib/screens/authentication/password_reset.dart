import 'package:fl/components/existing_account_check.dart';
import 'package:fl/widgets/constants.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:fl/services/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/screens/backgrounds/sign_up_bg.dart';
import 'package:fl/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fl/components/text_field_container.dart';

//enum AuthFormType { signIn, signUp }

class PasswordReset extends StatefulWidget {
  //final AuthFormType authFormType;
/*
  SignUp({
    Key key, @required this.authFormType
  }) : super(key: key);
*/
  @override
  _PasswordResetState createState() =>
      _PasswordResetState(//authFormType: this.authFormType
          );
}

class _PasswordResetState extends State<PasswordReset> {
  //AuthFormType authFormType;
  //_SignUpState({this.authFormType}); //instantiere

  final formKey = GlobalKey<FormState>();
  String _email;
  String _error;

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        await auth.sendPasswordResetEmail(_email);
        print("Password reset email sent");
        _error = "Reset link sent to $_email";
        Navigator.of(context).pushReplacementNamed('/signIn');
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showError(),
              SizedBox(height: size.height * 0.01), //1%
              AutoSizeText(
                'RESET YOUR PASSWORD',
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
                  text: "SEND PASSWORD RESET LINK",
                  press: () async {
                    submit();
                    //Navigator.of(context).pushReplacementNamed('/home');
                  }),
              SizedBox(height: size.height * 0.01),
              returnToSignIn(),
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
                  fontFamily: GoogleFonts.manjari(fontWeight: FontWeight.bold)
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
          onSaved: (value) => _email = value,
          validator: EmailValidator.validate,
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
              Icons.alternate_email_rounded,
              color: aPrimaryColor,
            ),
          ),
        ),
      ),
    );

    return inputFields;
  }

  Widget returnToSignIn() {
    return FlatButton(
        child: Text(
          "Return to sign in",
          style: TextStyle(
            color: aPrimaryColor,
            fontFamily:
                GoogleFonts.manjari(fontWeight: FontWeight.bold).fontFamily,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/signIn');
        });
  }
}
