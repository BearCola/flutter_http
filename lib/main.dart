import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//http://jsonplaceholder.typicode.com/posts
void main() async {
  List _data = await getJSON();
  print(_data[0]['title']);

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json Parsing'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Text(_data[0]['title']),
        ),
      ),
    ),
  );
}

Future<List> getJSON() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
