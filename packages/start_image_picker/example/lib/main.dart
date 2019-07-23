import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:start_image_picker/start_image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _imageFromCamera;
  File _imageFromGallery;
  File _videoFromCamera;
  File _videoFromGallery;
  int _selectedIndex = 0;

  void _pickImageFromCamera() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFromCamera = file;
    });
  }

  void _pickImageFromGallery() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.photoLibrary,
    );
    setState(() {
      _imageFromGallery = file;
    });
  }

  void _pickVideoFromCamera() async {
    final file = await ImagePicker.pickVideo(
      source: ImageSource.camera,
    );
    setState(() {
      _videoFromCamera = file;
    });
  }

  void _pickVideoFromGallery() async {
    final file = await ImagePicker.pickVideo(
      source: ImageSource.photoLibrary,
    );
    setState(() {
      _videoFromGallery = file;
    });
  }

  void _onNavigationBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavigationBarTap,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Camera'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.panorama),
              title: Text('Gallery'),
            ),
          ],
        ),
        body: _selectedIndex < 1 ? _camera() : _gallery(),
      ),
    );
  }

  Widget _camera() {
    return Column(
      children: <Widget>[
        Expanded(
          child: (_imageFromCamera != null)
              ? Image.file(_imageFromCamera)
              : Container(),
        ),
        FlatButton(
          onPressed: _pickImageFromCamera,
          child: Text('Pick from camera'),
        ),
        Expanded(
          child: (_imageFromGallery != null)
              ? Image.file(_imageFromGallery)
              : Container(),
        ),
        FlatButton(
          onPressed: _pickImageFromGallery,
          child: Text('Pick from camera'),
        ),
      ],
    );
  }

  Widget _gallery() {
    return Column(
      children: <Widget>[
        Expanded(
          child: (_videoFromCamera?.path != null)
              ? Text(_videoFromCamera?.path)
              : Container(),
        ),
        FlatButton(
          onPressed: _pickVideoFromCamera,
          child: Text('Pick from camera'),
        ),
        Expanded(
          child: (_videoFromGallery?.path != null)
              ? Text(_videoFromGallery?.path)
              : Container(),
        ),
        FlatButton(
          onPressed: _pickVideoFromGallery,
          child: Text('Pick from camera'),
        )
      ],
    );
  }
}
