import 'package:flutter/material.dart';
import 'package:firebase_authentication_with_flutter/auth.dart';

class Provider extends InheritedWidget {
  final BaseAuth auth;

  Provider({
    Key key,
    Widget child,
    this.auth,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

//   'inheritFromWidgetOfExactType' is deprecated and shouldn't be used. Use dependOnInheritedWidgetOfExactType instead. This feature was deprecated after v1.12.1..
// Try replacing the use of the deprecated member with the replacement.
  static Provider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider);
  // static Provider of(BuildContext context) =>
  //     (context.dependOnInheritedWidgetOfExactType(aspect: Provider)
  //         as Provider);
}
