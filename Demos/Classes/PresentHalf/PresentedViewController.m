//
//  PresentedViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()
@property (nonatomic) UIButton *closeButton;
@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (CGFloat)pHeight {
    return self.height;
}

- (void)onClickClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)closeButton {
    if(!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(onClickClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end
