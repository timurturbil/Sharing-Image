import 'dart:convert';
import 'dart:io';

import 'package:firebase_json/features/sample_fire/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> _userList = [];
  Future<List<UserModel>> fecthData() async {
    var url = 'https://fir-json-2d90c-default-rtdb.firebaseio.com/user.json';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse is List) {
        return jsonResponse.map((e) => UserModel.fromJson(e)).toList();
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildingbutton(),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    
    return ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${_userList[index].name}"),
          );
        });
  }

  FloatingActionButton buildingbutton() {
    return FloatingActionButton(
      child: Icon(Icons.get_app),
      onPressed: () async {
        final items = await fecthData();
        setState(() {
          _userList = items;
        });
      },
    );
  }
}
