import 'dart:io';

import 'package:firebase_json/features/sample_fire/blog/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheett extends StatefulWidget {
  final void Function(BlogModel model, File image) onCompleted;

  const BottomSheett({Key key, this.onCompleted}) : super(key: key);
  @override
  _BottomSheettState createState() => _BottomSheettState();
}

class _BottomSheettState extends State<BottomSheett> {
  final TextEditingController ilkController = TextEditingController();
  final TextEditingController ikinciController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("sadssss"),
        Expanded(child: _image == null ? Placeholder() : Image.file(_image)),
        TextField(
          controller: ilkController,
        ),
        TextField(
          controller: ikinciController,
        ),
        RaisedButton.icon(
            onPressed: () {
              getImage();
            },
            icon: Icon(Icons.add_a_photo),
            label: Text("add a photo")),
        RaisedButton.icon(
            onPressed: () {
              widget.onCompleted(
                  BlogModel(
                      title: ilkController.text,
                      description: ikinciController.text),
                   _image);
            },
            icon: Icon(Icons.done),
            label: Text("complete")),
      ],
    );
  }
}
