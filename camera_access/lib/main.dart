// import 'dart:html';
import 'package:camera_access/sendImage.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert' ;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


void main(){
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SendImage() 
    );

}
}





