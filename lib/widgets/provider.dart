import 'package:fl/services/auth.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final AuthService auth; //alerts all children that the auth state changed
  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();
}
