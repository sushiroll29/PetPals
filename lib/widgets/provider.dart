import 'package:fl/services/auth.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final AuthService auth; //alerts all children that the auth state changed
  final db;
  Provider({
    Key key,
    Widget child,
    this.auth,
    this.db,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider>();
}
