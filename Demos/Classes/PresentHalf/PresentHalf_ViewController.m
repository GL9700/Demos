//
//  PresentHalf_ViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import "PresentHalf_ViewController.h"
#import "PresentedViewController.h"

@interface PresentHalf_ViewController ()
@property (nonatomic) UIButton *button;
@end

@implementation PresentHalf_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [self ButtonWithTitle:@"弹出半屏" action:@selector(onPresentHalfViewController:)];
    [self.stackView addArrangedSubview:self.button];
}

- (void)onPresentHalfViewController:(UIButton *)sender {
    
    // 在目标ViewController中通过 `- (CGFloat)pHeight` 设定高度
    // 设定高度在 - viewWillAppera 中或之前有效
    
    [self presentViewController:[PresentedViewController new]
                   isOverScreen:true   // 是否Over下面的内容，true:浮层,false:不显示下方内容
                       animated:true
                     completion:^{
        NSLog(@"动画结束");
    }];
}

@end
