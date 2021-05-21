import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_task/helpers/auth.dart';

import 'background.dart';
import 'home.dart';

bool _isSignedIn = false;
bool get signInStatus => _isSignedIn;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Background(
                child: Form(
      key: _loginFormKey,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Username"),
              controller: emailInputController,
              validator: emailValidator,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              controller: pwdInputController,
              obscureText: true,
              validator: pwdValidator,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            // alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                if (_loginFormKey.currentState.validate()) {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailInputController.text,
                          password: pwdInputController.text)
                      .then((currentUser) => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => products())))
                      .catchError((err) => print(err));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: const EdgeInsets.all(0),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),
                padding: const EdgeInsets.all(0),
                child: Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            children: [
              Expanded(
                  child: Divider(
                thickness: 1,
                color: Colors.black38,
              )),
              Text('  OR  '),
              Expanded(
                  child: Divider(
                thickness: 1,
                color: Colors.black38,
              ))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            // alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                signIn().then((value) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => products())));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: const EdgeInsets.all(0),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.06,
                        child: Image.asset(
                          'assets/google.png',
                        ),
                      ),
                    ),
                    Text(
                      "Sign In with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ))
            // Container(
            //     padding: const EdgeInsets.all(20.0),
            //     child: SingleChildScrollView(
            //         child: Form(
            //       key: _loginFormKey,
            //       child: Column(
            //         children: <Widget>[
            //           TextFormField(
            //             decoration: InputDecoration(
            //                 labelText: 'Email*', hintText: "john.doe@gmail.com"),
            //             controller: emailInputController,
            //             keyboardType: TextInputType.emailAddress,
            //             validator: emailValidator,
            //           ),
            //           TextFormField(
            //             decoration: InputDecoration(
            //                 labelText: 'Password*', hintText: "********"),
            //             controller: pwdInputController,
            //             obscureText: true,
            //             validator: pwdValidator,
            //           ),
            //           RaisedButton(
            //             child: Text("Login"),
            //             color: Theme.of(context).primaryColor,
            //             textColor: Colors.white,
            //             onPressed: () {
            //               if (_loginFormKey.currentState.validate()) {
            //                 FirebaseAuth.instance
            //                     .signInWithEmailAndPassword(
            //                         email: emailInputController.text,
            //                         password: pwdInputController.text)
            //                     .then((currentUser) => FirebaseFirestore.instance
            //                         .collection("users")
            //                         .doc(currentUser.user.uid)
            //                         .get()
            //                         .then((value) => Navigator.pushReplacement(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => products())))
            //                         .catchError((err) => print(err)))
            //                     .catchError((err) => print(err));
            //               }
            //             },
            //           ),
            //           ElevatedButton(
            //             child: Text("Click here to Sign-in with Google!"),
            //             onPressed: () {
            //               signIn().then((value) => Navigator.of(context)
            //                   .pushReplacement(MaterialPageRoute(
            //                       builder: (context) => products())));
            //             },
            //           )
            //         ],
            //       ),
            //     )))
            ));
  }
}
