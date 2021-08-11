import 'package:flutter/material.dart';

import '../../Global_variables_methods.dart';

class CovidShield extends StatefulWidget {
  @override
  _CovidShieldState createState() => _CovidShieldState();
}

class _CovidShieldState extends State<CovidShield> {
  var myData = [];
  void getData() async {
    var response = await getRequest(
      'https://edamam-food-and-grocery-database.p.rapidapi.com/parser?ingr=apple',
      {
        'x-rapidapi-key': '58ecd702c2mshe9bb2d2d2874c5dp1b6cabjsna18cee0a6c23',
        'x-rapidapi-host': 'edamam-food-and-grocery-database.p.rapidapi.com'
      },
    );
    print(response['parsed']);
    setState(() {
      myData = ((response['hints']));
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
        title: Text('Edamam Food and Grocery Database'),
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
