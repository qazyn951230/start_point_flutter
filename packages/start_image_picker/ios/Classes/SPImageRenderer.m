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

#import "SPImageRenderer.h"

@implementation SPImageRenderer

+ (NSData *)renderImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    if (image == nil) {
        return nil;
    }
    CGFloat iw = image.size.width;
    CGFloat ih = image.size.height;
    if (iw < 1 || ih < 1) {
        return nil;
    }
    CGSize size = image.size;
    if (width > 0.99) {
        if (height > 0.99) { // width >= 1 && height >= 1
            size = CGSizeMake(width, height);
        } else { // width >= 1 && height < 1 => height
            size = CGSizeMake(width, ih / iw * width);
        }
    } else if (height > 0.99) { // height >= 1 && width < 1 => width
        size = CGSizeMake(iw / ih * height, height);
    }
    size = CGSizeMake(round(size.width), round(size.height));
    if (size.width < 1 || size.height < 1) {
        return nil;
    }
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    format.scale = image.scale;
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size format:format];
    return [render JPEGDataWithCompressionQuality:1.0 actions:^(UIGraphicsImageRendererContext *context) {
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    }];
}

@end
