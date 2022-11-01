import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_auth/screen/splash_screen.dart';
import 'package:user_auth/widget/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final emailController = new TextEditingController();
  final firstnameController = new TextEditingController();
  final lastnameController = new TextEditingController();
  final passwordController = new TextEditingController();
  bool isLogin = true;
  bool ischecked = false;
  void sendUserDetails() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    await firestore.collection('users').doc(user!.uid).set({
      'email': user.email,
      'uid': user.uid,
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
    });
  }

  void signup(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                sendUserDetails(),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SplashScreen())),
              })
          .catchError((e) {
        return e.toString();
      });
    }
  }

  void login(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                // sendUserDetails(),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SplashScreen()))
              })
          .catchError((e) {
        return e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Color.fromARGB(133, 159, 204, 255),
              height: 300,
              child: Center(child: Text('palyback video')),
            ),
            Form(
                key: _formkey,
                child: Container(
                  height: 400,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          TextFieldWidget('email', Icon(Icons.email_outlined),
                              emailController),
                          TextFieldWidget('password', Icon(Icons.lock_outline),
                              passwordController),
                          isLogin
                              ? Container()
                              : TextFieldWidget(
                                  'first name',
                                  Icon(Icons.person_outline),
                                  firstnameController),
                          isLogin
                              ? Container()
                              : TextFieldWidget(
                                  'last name',
                                  Icon(Icons.person_outline),
                                  lastnameController),
                          isLogin
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: ischecked,
                                            onChanged: (value) {
                                              setState(() {
                                                ischecked = !ischecked;
                                              });
                                            },
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  ischecked = !ischecked;
                                                });
                                              },
                                              child: Text('Remember me')),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: sendUserDetails,
                                          child: Text('Forgot Password?'))
                                    ])
                              : Container(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 17)),
                            onPressed: isLogin
                                ? () {
                                    login(emailController.text,
                                        passwordController.text);
                                  }
                                : () {
                                    signup(emailController.text,
                                        passwordController.text);
                                  },
                            child: isLogin ? Text("Login") : Text('Sign-Up'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLogin
                                  ? Text('Don\'t have an account?')
                                  : Text('Already have an account'),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child:
                                      isLogin ? Text('SIGN UP') : Text('Login'))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
