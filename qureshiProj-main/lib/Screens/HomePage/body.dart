import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_auth/Screens/HomePage/covid_sense.dart';
import 'package:flutter_auth/Screens/HomePage/covid_shield.dart';
import 'package:flutter_auth/Screens/HomePage/withings_app.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bottom_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color(0xFF545D68)),
          onPressed: () {},
        ),
        title: Text('Health App',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF545D68)),
            onPressed: () {
              auth.signOut();
              displayToastMessage('You have logged out!', context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Data Categories',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Varela',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.purple.shade300,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Withings App',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('CovidShield',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('CovidSense',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )),
                )
              ]),
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            child: TabBarView(
                controller: _tabController,
                children: [
                  WithingsApp(),
                  CovidShield(),
                  CovidSense(),
                ]
            )
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
