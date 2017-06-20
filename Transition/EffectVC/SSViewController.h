//
//  ViewController.h
//   打印机过渡效果
//
//  Created by lss on 2017/6/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSViewController : UIViewController

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CIContext *ci_context;

@property (nonatomic, strong) CIImage *ci_inputImage;

@property (nonatomic, strong) CIImage *ci_tagerImage;

@property (nonatomic, strong) CIFilter *ci_filter;

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

