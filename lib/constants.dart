import 'package:flutter/material.dart';

const aPrimaryColor = Color.fromRGBO(157, 68, 75, 1.0);
const aPrimaryStartingColor = Color.fromRGBO(157, 68, 75, 0.98);
const aPrimaryLightColor = Color.fromRGBO(230, 230, 230, 1.0);
const aErrorColor = Colors.red;

final RegExp emailValidationExp =
    RegExp(r"^[a-zA-Z0-9].+@[a-zA-Z0-9]+\.[a-zA-Z]");
