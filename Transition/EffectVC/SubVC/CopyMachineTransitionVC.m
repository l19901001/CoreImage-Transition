//
//  CopyMachineTransitionVC.m
//  Transition
//
//  Created by lss on 2017/6/19.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "CopyMachineTransitionVC.h"

@interface CopyMachineTransitionVC ()


@end

@implementation CopyMachineTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ci_filter = [CIFilter filterWithName:self.filterName];
    [self.ci_filter setValue:self.ci_inputImage forKey:@"inputImage"];
    [self.ci_filter setValue:self.ci_tagerImage forKey:@"inputTargetImage"];
    CIVector *extent = [CIVector vectorWithCGRect:self.ci_inputImage.extent];
    [self.ci_filter setValue:extent forKey:@"inputExtent"];
}

-(void)transition:(CGFloat)t
{
    CIImage *ciimage = [self imageForTransitionAtTime:t];
    
    CIFilter *crop = [CIFilter filterWithName:@"CICrop"];
    [crop setValue:ciimage forKey:@"inputImage"];
    CIVector *vector = [CIVector vectorWithX:0 Y:0 Z:self.ci_inputImage.extent.size.width W:self.ci_inputImage.extent.size.height];
    [crop setValue:vector forKey:@"inputRectangle"];
    CIImage *resultImage = [crop valueForKey:kCIOutputImageKey];
    ;
    CGImageRef imageRef = [self.ci_context createCGImage:resultImage fromRect:resultImage.extent];
    
    self.imageView.image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
}

-(void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
