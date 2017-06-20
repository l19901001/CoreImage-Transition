//
//  AccordionFoldVC.m
//  Transition
//
//  Created by lss on 2017/6/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "AccordionFoldVC.h"

@interface AccordionFoldVC ()



@end

@implementation AccordionFoldVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ci_filter = [CIFilter filterWithName:self.filterName];
    [self.ci_filter setValue:self.ci_inputImage forKey:@"inputImage"];
    [self.ci_filter setValue:self.ci_tagerImage forKey:@"inputTargetImage"];
    [self.ci_filter setValue:@(1) forKey:@"inputNumberOfFolds"];
    [self.ci_filter setValue:@(0.5) forKey:@"inputFoldShadowAmount"];
    [self.ci_filter setValue:@(1) forKey:@"inputBottomHeight"];
}

-(void)transition:(CGFloat)t
{
    CIImage *ciimage = [self imageForTransitionAtTime:t];
    CIFilter *crop = [CIFilter filterWithName:@"CICrop"];
    [crop setValue:ciimage forKey:@"inputImage"];
    CIVector *vector = [CIVector vectorWithX:0 Y:0 Z:self.ci_inputImage.extent.size.width W:self.ci_inputImage.extent.size.height];
    [crop setValue:vector forKey:@"inputRectangle"];
    CIImage *resultImage = [crop valueForKey:kCIOutputImageKey];
    
    CGImageRef imageRef = [self.ci_context createCGImage:resultImage fromRect:resultImage.extent];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    });
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
