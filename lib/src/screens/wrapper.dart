import 'package:firebase_authentication_with_flutter/src/providers/provider.dart';
import 'package:firebase_authentication_with_flutter/src/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print('----------user: ${user.nameUser}');

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home(
        userCurrent: user,
      );
    }
  }
}
