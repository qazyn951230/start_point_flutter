import 'dart:async';
import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum ImageSource {
  camera,
  photoLibrary,
}

enum VideoQuality {
  high,
  medium,
  low,
  minimum,
}

class ImagePicker {
  static const MethodChannel _channel =
      const MethodChannel('plugins.undev.com/image_picker');

  static Future<File> pickImage({
    @required ImageSource source,
    double maxWidth,
    double maxHeight,
  }) async {
    assert(source != null);
    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }
    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }
    final String path = await _channel.invokeMethod<String>(
      'pickImage',
      <String, dynamic>{
        'source': source.index,
        'maxWidth': maxWidth,
        'maxHeight': maxHeight,
      },
    );
    return path == null ? null : File(path);
  }

  static Future<File> pickVideo({
    @required ImageSource source,
    double duration,
    VideoQuality quality,
  }) async {
    assert(source != null);
    if (duration != null && duration < 0) {
      throw ArgumentError.value(duration, 'duration cannot be negative');
    }
    final String path = await _channel.invokeMethod<String>(
      'pickVideo',
      <String, dynamic>{
        'source': source.index,
        'duration': duration,
        'quality': quality,
      },
    );
    return path == null ? null : File(path);
  }
}
