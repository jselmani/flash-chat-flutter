import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './chat_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: isLoading
            ? Center(
                child: SpinKitCubeGrid(
                  color: Colors.lightBlue,
                  size: 50.0,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your e-mail',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    color: Colors.blueAccent,
                    title: 'Register',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
