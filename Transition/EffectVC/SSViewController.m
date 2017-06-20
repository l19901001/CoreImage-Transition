//
//  ViewController.m
//   打印机过渡效果
//
//  Created by lss on 2017/6/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()



@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    self.images = @[@"image1.jpg", @"image2.jpg", @"image3.jpg"];
    
    self.ci_context = [CIContext contextWithOptions:nil];
    
    UIImage *inputImage = [UIImage imageNamed:self.images[0]];
    self.ci_inputImage = [CIImage imageWithCGImage:inputImage.CGImage];
    
    UIImage *tagerImage = [UIImage imageNamed:self.images[1]];
    self.ci_tagerImage = [CIImage imageWithCGImage:tagerImage.CGImage];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeFire:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)timeFire:(id)sender
{
    
}

-(UIImageView *)imageView
{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 250);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.image = [UIImage imageNamed:@"image1.jpg"];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
