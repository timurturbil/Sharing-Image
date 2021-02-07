import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_json/core/network/firebase_Extention.dart';
import 'package:firebase_json/features/sample_fire/blog/model/blog_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'blog.dart';

abstract class BlogViewModel extends State<Blog> {
  final firebaseDataBaseDio = Dio(BaseOptions(
      baseUrl: 'https://fir-json-2d90c-default-rtdb.firebaseio.com'));
  final firebaseStorageDio = Dio();
/*   final firebaseStorageDio =
      Dio(BaseOptions(baseUrl: 'fir-json-2d90c.appspot.com')); */


  Future<void> addPosttoFirebase(BlogModel blogModel, File file) async {

    var selectedFile = file.path.toString();
    var urll = selectedFile.substring(57, 75);
    
    final uploadFile = await _uploadFiletoServer(file);
    blogModel.imageUrl =
        '$urll'.toFirebaseCloudUrl('fir-json-2d90c.appspot.com');
    final postUpload = await _sendDatabase(blogModel);
  }

  Future<void> _uploadFiletoServer(File file) async {
    var selectedFile = file.path.toString();
    var urll = selectedFile.substring(57, 75);
    var fileName = file.path.split('/').last;
    var formData = FormData.fromMap(
        {'file': await MultipartFile.fromFile(file.path, filename: fileName)});

    // ignore: unnecessary_statements
    final response = await firebaseStorageDio.post(
        '$urll'.toFirebaseCloudUrl('fir-json-2d90c.appspot.com'),
        data: formData);

    return response.statusCode == HttpStatus.ok;
  }


  Future<void> _sendDatabase(BlogModel model) async {
    final response = await firebaseDataBaseDio.post('/image.json', data: model);

    return response.statusCode == HttpStatus.ok;
  }
}
