import 'package:flutter/material.dart';
import 'package:flutter_auth/Global_variables_methods.dart';
import 'package:flutter_auth/Screens/HomePage/covid_shield.dart';

class CovidSense extends StatefulWidget {
  @override
  _CovidSenseState createState() => _CovidSenseState();
}

class _CovidSenseState extends State<CovidSense> {
  List myData = [];
  void getData() async {
    var response = await getRequest(
        'https://endlessmedicalapi1.p.rapidapi.com/GetOutcomes', {
      'x-rapidapi-key': '58ecd702c2mshe9bb2d2d2874c5dp1b6cabjsna18cee0a6c23',
      'x-rapidapi-host': 'endlessmedicalapi1.p.rapidapi.com'
    });
    setState(() {
      myData = ((response['data']));
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CovidShield(),
              ),
            );
          },
        ),
        title: Text('EndlessMedicalAPI'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text('${myData[index]}');
        },
        itemCount: myData.length,
      ),
    );
  }
}
