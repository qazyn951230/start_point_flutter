import 'dart:io' show File;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:start_image_picker/start_image_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('plugins.undev.com/image_picker');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '/foobar';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('pickImage', () async {
    final file = await ImagePicker.pickImage(source: ImageSource.camera);
    expect(file.path, '/foobar');
  });
}
