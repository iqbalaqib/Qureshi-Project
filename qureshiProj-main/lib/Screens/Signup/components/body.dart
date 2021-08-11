import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
              child: TextFormField(
                key: _formKey1,
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
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
              child: TextFormField(
                  key: _formKey2,
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Enter a password with 6+ characters'
                      : null,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Your Password",
                      fillColor: Colors.purple.shade100),
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
            ),
            RaisedButton(
              color: Colors.purple.shade100,
              child: Text("SIGNUP"),
              onPressed: () async {
                _auth.createUserWithEmailAndPassword(email: email, password: password);
                displayToastMessage('You have successfully signed up! Login to continue. ', context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
