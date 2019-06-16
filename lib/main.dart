import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//http://jsonplaceholder.typicode.com/posts
void main() async {
  List _data = await getJSON();

  List _currencies = await getCurrencies();

  for (int i = 0; i < _currencies.length; i++) {
    print(_currencies[i]['name']);
    print(_currencies[i]['address']['street']);
    print(_currencies[i]['address']['geo']);
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Json Parsing'),
          backgroundColor: Colors.orange,
        ),
        body: ListView.builder(
          itemCount: _data.length,
          padding: EdgeInsets.all(4.4),
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: <Widget>[
                Divider(
                  height: 13.4,
                ),
                ListTile(
                  title: Text(
                    _data[position]['title'],
                    style:
                        TextStyle(fontSize: 17.2, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_data[position]['body']),
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(_data[position]['title'][0]),
                  ),
                  onTap: () {
                    showTapMessage(context, _data[position]['title']);
                  },
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

void showTapMessage(BuildContext context, String data) {
  var alertDialog = AlertDialog(
    title: Text(data),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Ok'),
      )
    ],
  );

  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}

Future<List> getJSON() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

Future<List> getCurrencies() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/users';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
