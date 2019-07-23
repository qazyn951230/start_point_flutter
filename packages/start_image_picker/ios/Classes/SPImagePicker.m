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

#import <pthread.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreServices/CoreServices.h>
#import <Photos/Photos.h>
#import "SPImagePicker.h"
#import "SPImageRenderer.h"

static void onMainQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

static BOOL isMainQueue() {
    return pthread_main_np() != 0;
}

@interface SPImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) UIViewController *viewController;
@property(nonatomic, copy) FlutterResult result;
@end

@implementation SPImagePicker

- (instancetype)init {
    self = [super init];
    if (self) {
        _sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _maximumWidth = 0;
        _maximumHeight = 0;
        _videoQuality = UIImagePickerControllerQualityTypeMedium;
        _videoMaximumDuration = 600;
        _viewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    }
    return self;
}

- (void)dealloc {
    [self sendError:@"plugin_dealloc" message:@"Dealloc before get result"];
}

- (BOOL)hasResult {
    return _result != nil;
}

- (void)reset {
    assert(_result == nil);
    _sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _maximumWidth = 0;
    _maximumHeight = 0;
    _videoQuality = UIImagePickerControllerQualityTypeMedium;
    _videoMaximumDuration = 600;
    _viewController = UIApplication.sharedApplication.keyWindow.rootViewController;
}

- (void)pickImageToResult:(FlutterResult)result {
    if (![UIImagePickerController isSourceTypeAvailable:_sourceType]) {
        [self sendResult:nil];
        return;
    }
    [self prepareForNextResult:result];
    if (_sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self checkVideoStatusThen:^{
            [self doPickImage];
        }];
    } else {
        [self checkPhotoLibraryStatusThen:^{
            [self doPickImage];
        }];
    }
}

- (void)pickVideoToResult:(FlutterResult)result {
    if (![UIImagePickerController isSourceTypeAvailable:_sourceType]) {
        [self sendResult:nil];
        return;
    }
    [self prepareForNextResult:result];
    if (_sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self checkVideoAudioStatusThen:^{
            [self doPickVideo];
        }];
    } else {
        [self checkPhotoLibraryStatusThen:^{
            [self doPickVideo];
        }];
    }
}

- (void)doPickImage {
    assert(isMainQueue());
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = _sourceType;
    picker.mediaTypes = @[(__bridge NSString *) kUTTypeImage];
    [_viewController presentViewController:picker animated:YES completion:nil];
}

- (void)doPickVideo {
    assert(isMainQueue());
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = _sourceType;
    picker.mediaTypes = @[(__bridge NSString *) kUTTypeVideo, (__bridge NSString *) kUTTypeMovie,
                          (__bridge NSString *) kUTTypeMPEG4, (__bridge NSString *) kUTTypeAVIMovie];
    picker.videoQuality = _videoQuality;
    picker.videoMaximumDuration = _videoMaximumDuration;
    [_viewController presentViewController:picker animated:YES completion:nil];
}

- (void)prepareForNextResult:(FlutterResult)result {
    [self sendError:@"multiple_request" message:@"Cancelled by a second request"];
    _result = result;
}

- (void)checkVideoStatusThen:(void (^)(void))then {
    [self requestAccessForMediaType:AVMediaTypeVideo then:then];
}

- (void)checkVideoAudioStatusThen:(void (^)(void))then {
    [self requestAccessForMediaType:AVMediaTypeVideo then:^{
        [self requestAccessForMediaType:AVMediaTypeAudio then:then];
    }];
}

- (void)checkPhotoLibraryStatusThen:(void (^)(void))then {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        then();
        return;
    }
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            onMainQueue(^{
                then();
            });
        } else {
            [self sendPhotoLibraryAuthorizationError];
        }
    }];
}

- (void)requestAccessForMediaType:(AVMediaType)mediaType then:(void (^)(void))then {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (status == AVAuthorizationStatusAuthorized) {
        then();
        return;
    }
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (granted) {
            onMainQueue(^{
                then();
            });
        } else {
            [self sendAuthorizationErrorForMediaType:mediaType];
        }
    }];
}

- (void)sendAuthorizationErrorForMediaType:(AVMediaType)mediaType {
    NSString *code;
    NSString *message;
    if ([mediaType isEqualToString:AVMediaTypeVideo]) {
        code = @"video_access_denied";
        message = @"The user is not allowed to access the camera.";
    } else {
        code = @"audio_access_denied";
        message = @"The user is not allowed to access the microphone.";
    }
    [self sendError:code message:message];
}

- (void)sendPhotoLibraryAuthorizationError {
    [self sendError:@"photo_access_denied"
            message:@"The user did not allow to access photo library."];
}

- (void)sendError:(NSString *)code message:(NSString *)message {
    if (_result == nil) {
        return;
    }
    _result([FlutterError errorWithCode:code
                                message:message
                                details:nil]);
    _result = nil;
}

- (void)sendResult:(id)result {
    if (_result == nil) {
        return;
    }
    _result(result);
    _result = nil;
}

#pragma MARK - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_result == nil) {
        return;
    }
    NSString *type = info[UIImagePickerControllerMediaType];
    BOOL isImage = [type isEqualToString:(__bridge NSString *) kUTTypeImage];
    if (isImage) {
        UIImage *image = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
        NSData *data = [SPImageRenderer renderImage:image width:_maximumWidth height:_maximumHeight];
        if (data != nil) {
            NSString *path = [SPImagePicker saveImage:data];
            [self sendResult:path];
        } else {
            [self sendResult:nil];
        }
    } else {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        NSString *path = [SPImagePicker saveVideoFromURL:url];
        [self sendResult:path];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self sendResult:nil];
}

#pragma MARK - Save Image or Video to Disk

+ (NSString *)saveImage:(NSData *)image {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *directory = NSTemporaryDirectory();
    [manager createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *filename = NSProcessInfo.processInfo.globallyUniqueString;
    NSURL *url = [[[NSURL alloc] initFileURLWithPath:directory] URLByAppendingPathComponent:filename];
    return [image writeToURL:url atomically:YES] ? url.path : nil;
}

+ (NSString *)saveVideoFromURL:(NSURL *)url {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (!(url && [manager fileExistsAtPath:url.path])) {
        return nil;
    }
    NSString *directory = NSTemporaryDirectory();
    [manager createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:nil];
    NSString *filename = NSProcessInfo.processInfo.globallyUniqueString;
    NSURL *toUrl = [[[NSURL alloc] initFileURLWithPath:directory] URLByAppendingPathComponent:filename];
    BOOL result = [manager copyItemAtURL:url toURL:toUrl error:nil];
    return result ? url.path : nil;
}

@end
