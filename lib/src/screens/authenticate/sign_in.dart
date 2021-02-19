import 'package:firebase_authentication_with_flutter/src/shared/constants.dart';
import 'package:firebase_authentication_with_flutter/src/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text('Sign in to Brew Crew'),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Resgister'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) {
                        return value.isEmpty ? 'Enter an Email' : null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) {
                        return value.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          // dynamic result = await _auth
                          //     .signInWithEmailAndPassword(email, password);
                          // if (result == null) {
                          //   setState(() {
                          //     error =
                          //         'could not sign in with those credentials';
                          //     loading = false;
                          //   });
                          // } else {}
                        } else {}
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

// class _buildButtonSignIn extends StatelessWidget {
//   const _buildButtonSignIn({
//     Key key,
//     @required AuthService auth,
//   })  : _auth = auth,
//         super(key: key);

//   final AuthService _auth;

//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       child: Text('Sign in anon'),
//       onPressed: () async {
//         dynamic result = await _auth.signInAnon();
//         if (result == null) {
//           print('loi dang nhap');
//         } else {
//           print('sign in');
//           print(result.uid);
//         }
//       },
//     );
//   }
// }
