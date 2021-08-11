import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getRequest(
  String url,
  Map<String, String> headers,
) async {
  http.Response response = await http.get(Uri.parse(url), headers: headers);

  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return jsonDecode(response.body);
    }
  } catch (e) {
    return 'failed';
  }
}
