import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_json/features/sample_fire/blog/model/blog_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetstateHomePage extends StatefulWidget {
  @override
  _SetstateHomePageState createState() => _SetstateHomePageState();
}

class _SetstateHomePageState extends State<SetstateHomePage> {
  final firebaseDataBaseDio = Dio(BaseOptions(
      baseUrl: 'https://fir-json-2d90c-default-rtdb.firebaseio.com'));

  @override
  void initState() {
    super.initState();
    fetchFirebaseDatas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogModel>>(
      future: fetchFirebaseDatas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Scrollbar(
            child: RefreshIndicator(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                        aspectRatio: 2,
                        child: Card(
                            child: ListTile(
                          title: AspectRatio(
                              aspectRatio: 2.3,
                              child: Image.network(
                                  "${snapshot.data[index].imageUrl}")),
                          subtitle: Text("${snapshot.data[index].title}"),
                        )));
                  }),
              onRefresh: refreshList,
            ),
            
          );
        } else {
          return Text("veri yok");
        }
      },
    );
  }

  Future<void> refreshList() async {
    // reload
    setState(() {
      fetchFirebaseDatas();
    });
  }

  Future<List<BlogModel>> fetchFirebaseDatas() async {
    final response = await firebaseDataBaseDio.get('/image.json');

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseData = response.data;
        if (responseData is Map) {
          final items = responseData.values.map((value) {
            final item = BlogModel.fromJson(value);
            item.key = responseData.keys
                .singleWhere((element) => responseData[element] == value);
            return item;
          }).toList();

          return items;
        } else {}

        break;
      default:
        throw Exception();
    }
  }
}
