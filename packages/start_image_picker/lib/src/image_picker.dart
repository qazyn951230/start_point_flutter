// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
//     Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
//     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
//     copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
