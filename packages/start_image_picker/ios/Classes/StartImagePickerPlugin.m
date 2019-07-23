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

#import "StartImagePickerPlugin.h"
#import "SPImagePicker.h"

@interface StartImagePickerPlugin () {
    SPImagePicker *_picker;
}
@end

@implementation StartImagePickerPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"plugins.undev.com/image_picker"
                                                                binaryMessenger:[registrar messenger]];
    StartImagePickerPlugin *instance = [[StartImagePickerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *name = call.method;
    if ([name isEqualToString:@"pickImage"]) {
        [self pickImageOrVideo:YES call:call result:result];
    } else if ([name isEqualToString:@"pickVideo"]) {
        [self pickImageOrVideo:NO call:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)pickImageOrVideo:(BOOL)isImage call:(FlutterMethodCall *)call result:(FlutterResult)result {
    if (_picker != nil) {
        if (_picker.hasResult) {
            result([FlutterError errorWithCode:@"multiple_request"
                                       message:@"Cancelled by a second request"
                                       details:nil]);
            return;
        } else {
            [_picker reset];
        }
    } else {
        _picker = [[SPImagePicker alloc] init];
    }
    NSDictionary *map = call.arguments;
    NSNumber *source = map[@"source"];
    NSNumber *maxWidth = map[@"maxWidth"];
    NSNumber *maxHeight = map[@"maxHeight"];
    NSNumber *duration = map[@"duration"];
    NSNumber *quality = map[@"quality"];
    if (source && source != (id) [NSNull null]) {
        switch (source.intValue) {
            case 0: // Camera
                _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1: // PhotoLibrary
                _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                result([FlutterError errorWithCode:@"invalid_argument"
                                           message:@"Invalid image source."
                                           details:nil]);
                break;
        }
    } else {
        result([FlutterError errorWithCode:@"invalid_argument"
                                   message:@"Image source required."
                                   details:nil]);
    }
    if (isImage) {
        if (maxWidth && maxWidth != (id) [NSNull null]) {
            _picker.maximumWidth = maxWidth.doubleValue;
            if (_picker.maximumWidth < 0) {
                result([FlutterError errorWithCode:@"invalid_argument"
                                           message:@"Max width cannot be negative."
                                           details:nil]);
            }
        }
        if (maxHeight && maxHeight != (id) [NSNull null]) {
            _picker.maximumHeight = maxHeight.doubleValue;
            if (_picker.maximumHeight < 0) {
                result([FlutterError errorWithCode:@"invalid_argument"
                                           message:@"Max height cannot be negative."
                                           details:nil]);
            }
        }
    } else {
        if (quality && quality != (id) [NSNull null]) {
            switch (quality.intValue) {
                case 0: // High
                    _picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
                    break;
                case 1: // Medium
                    _picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
                    break;
                case 2: // Low
                    _picker.videoQuality = UIImagePickerControllerQualityType640x480;
                    break;
                case 3: // Minimum
                    _picker.videoQuality = UIImagePickerControllerQualityTypeLow;
                    break;
                default:
                    result([FlutterError errorWithCode:@"invalid_argument"
                                               message:@"Invalie video quality."
                                               details:nil]);
                    break;
            }
        }
        if (duration && duration != (id) [NSNull null]) {
            _picker.videoMaximumDuration = duration.doubleValue;
            if (_picker.videoMaximumDuration < 0) {
                result([FlutterError errorWithCode:@"invalid_argument"
                                           message:@"Video maximum duration cannot be negative."
                                           details:nil]);
            }
        }
    }
    if (isImage) {
        [_picker pickImageToResult:result];
    } else {
        [_picker pickVideoToResult:result];
    }
}

@end
