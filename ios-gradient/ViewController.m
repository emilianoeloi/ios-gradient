//
//  ViewController.m
//  ios-gradient
//
//  Created by Emiliano Barbosa on 8/7/15.
//  Copyright (c) 2015 Bocamuchas. All rights reserved.
//

#import "ViewController.h"

#define MAGIC_NUMBER 100.0f
#define ANIMATION_INTERVAL 0.3f
#define ALPHA_TO_HIDE 0.0f
#define ALPHA_TO_SHOW 1.0f

@interface ViewController ()

@property (nonatomic) BOOL isSwapped;
@property (nonatomic, strong) IBOutlet UIView *box;
@property (nonatomic, strong) IBOutlet UIView *fadeBox;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *boxVerticalSpace;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSwapped = NO;
    [self setupBox];
}

-(void)setupBox{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _fadeBox.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [_fadeBox.layer insertSublayer:gradient atIndex:0];
    
    UITapGestureRecognizer *singleBoxTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swap)];
    [_box addGestureRecognizer:singleBoxTap];
    
    UITapGestureRecognizer *singleFadeBoxTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swap)];
    [_fadeBox addGestureRecognizer:singleFadeBoxTap];
    
}

-(void)swap{
    [self.view setNeedsLayout];
    [UIView animateWithDuration:ANIMATION_INTERVAL animations:^{
        if (_isSwapped) {
            [_boxVerticalSpace setConstant:0];
            [_box setBackgroundColor:[UIColor greenColor]];
            [_box setAlpha:ALPHA_TO_SHOW];
            [_fadeBox setAlpha:ALPHA_TO_HIDE];
        }else{
            [_boxVerticalSpace setConstant:MAGIC_NUMBER];
            
            [_box setAlpha:ALPHA_TO_HIDE];
            [_fadeBox setAlpha:ALPHA_TO_SHOW];
        }
        _isSwapped = !_isSwapped;
        [self.view layoutIfNeeded];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
