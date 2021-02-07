import 'dart:io';

import 'package:firebase_json/features/sample_fire/blog/ek.dart';
import 'package:firebase_json/features/sample_fire/blog/lifecirclepage.dart';
import 'package:firebase_json/features/sample_fire/blog/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'blog_view_model.dart';

class BlogView extends BlogViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => BottomSheett(
                    onCompleted: (model, image) {
                      addPosttoFirebase(model, image);
                    },
                  ));
        },
      ),
      appBar: AppBar(
        title: Text("heeey"),
      ),
      body: SetstateHomePage(),
    );
  }
}
