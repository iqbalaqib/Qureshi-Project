import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/HomePage/body.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/api/local_auth_api.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/Screens/HomePage/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Your Email",
                      fillColor: Colors.purple.shade100),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                child: TextFormField(
                  validator: (val) => val.length < 6
                      ? 'Enter a password with 6+ characters'
                      : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Your Password",
                      fillColor: Colors.purple.shade100),
                  controller: _passwordController,
                ),
              ),
              RoundedButton(
                textColor: Colors.black,
                color: Colors.purple.shade100,
                text: "LOGIN",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    await _signInWithEmailAndPassword();
                    displayToastMessage('Welcome to Health App!', context);
                  }
                  FirebaseAuth.instance.currentUser != null
                      ? Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => homeScreen()))
                      : null;
                  displayToastMessage(
                      'Please login with valid email and password', context);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }





  Future<bool> _signInWithEmailAndPassword() async {
    (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
