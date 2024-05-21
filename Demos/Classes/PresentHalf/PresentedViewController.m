//
//  PresentedViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()
@property (nonatomic) CGFloat height;
@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.height = 200;
}

- (CGFloat)pHeight {
    return self.height;
}

@end
