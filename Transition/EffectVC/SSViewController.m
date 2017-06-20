//
//  ViewController.m
//
//  Created by lss on 2017/6/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()

@property (nonatomic, strong) UIButton *startBut;

@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation SSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.startBut];
    self.images = @[@"image1.jpg", @"image2.jpg", @"image3.jpg"];
    
    self.ci_context = [CIContext contextWithOptions:nil];
    
    UIImage *inputImage = [UIImage imageNamed:self.images[0]];
    self.ci_inputImage = [CIImage imageWithCGImage:inputImage.CGImage];
    
    UIImage *tagerImage = [UIImage imageNamed:self.images[1]];
    self.ci_tagerImage = [CIImage imageWithCGImage:tagerImage.CGImage];
    
    UIImage *maskImage = [UIImage imageNamed:self.images[2]];
    self.ci_maskImage = [CIImage imageWithCGImage:maskImage.CGImage];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"复原" style:UIBarButtonItemStylePlain target:self action:@selector(resume)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeFire:)];
    self.baseTime = [NSDate timeIntervalSinceReferenceDate];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.ci_filter = nil;
    self.ci_context = nil;
    self.imageView = nil;
}

-(void)timeFire:(id)sender
{
    CGFloat t = 0.4 * ([NSDate timeIntervalSinceReferenceDate] - self.baseTime);
    [self transition:t];
}

-(void)resume
{
    self.startBut.selected = YES;
    [self clickBut:_startBut];
    self.imageView.image = [UIImage imageNamed:self.images[0]];
}

-(void)clickBut:(UIButton *)but
{
    but.selected = !but.isSelected;
    if(but.selected){
        self.displayLink.paused = NO;
        _startBut.layer.borderColor = [UIColor grayColor].CGColor;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }else{
        _startBut.layer.borderColor = [UIColor yellowColor].CGColor;
        self.displayLink.paused = YES;
    }
}

-(void)transition:(CGFloat)t
{
    NSAssert([self.class respondsToSelector:@selector(transition:)], @"子类实现");
}

- (CIImage *)imageForTransitionAtTime:(float)time
{
    if (fmodf(time, 2.0) < 1.0f)
    {
        [self.ci_filter setValue:self.ci_inputImage forKey:@"inputImage"];
        [self.ci_filter setValue:self.ci_tagerImage forKey:@"inputTargetImage"];
    }
    else
    {
        [self.ci_filter setValue:self.ci_tagerImage forKey:@"inputImage"];
        [self.ci_filter setValue:self.ci_inputImage forKey:@"inputTargetImage"];
    }
    
    CGFloat transitionTime = 0.5 * (1 - cos(fmodf(time, 1.0f) * M_PI));
    [self.ci_filter setValue:@(transitionTime) forKey:@"inputTime"];
    
    CIImage *transitionImage = [self.ci_filter valueForKey:@"outputImage"];
    
    return transitionImage;
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

-(UIButton *)startBut
{
    if(_startBut == nil){
        _startBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBut setTitle:@"开始" forState:UIControlStateNormal];
        [_startBut setTitle:@"停止" forState:UIControlStateSelected];
        [_startBut sizeToFit];
        _startBut.frame = CGRectMake(0, 0, _startBut.bounds.size.width+30, _startBut.bounds.size.height+10);
        CGPoint center = self.view.center;
        center.y += 100;
        _startBut.center = center;
        _startBut.clipsToBounds = YES;
        _startBut.layer.cornerRadius = 5.f;
        _startBut.backgroundColor = [UIColor greenColor];
        _startBut.layer.borderWidth = 2.f;
        _startBut.layer.borderColor = [UIColor yellowColor].CGColor;
        
        [_startBut addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBut;
}

-(void)dealloc
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.ci_filter = nil;
    self.ci_context = nil;
    self.imageView = nil;
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
