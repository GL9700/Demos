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
@property (nonatomic) UITextField *heightTextField;
@end

@implementation PresentHalf_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [self ButtonWithTitle:@"弹出半屏" action:@selector(onPresentHalfViewController:)];
    
    [self.view addSubview:self.heightTextField];
    [self.heightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@44);
    }];
    
    [self.stackView addArrangedSubview:self.button];
    [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.heightTextField.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

- (void)onPresentHalfViewController:(UIButton *)sender {
    
    // 在目标ViewController中通过 `- (CGFloat)pHeight` 设定高度
    // 设定高度在 - viewWillAppera 中或之前有效
    PresentedViewController *pvc = [PresentedViewController new];
    pvc.height = [self.heightTextField.text floatValue];
    [self presentViewController:pvc animated:true completion:^{
        NSLog(@"动画结束");
    }];
}
- (UITextField *)heightTextField {
    if(!_heightTextField) {
        _heightTextField = [UITextField new];
        _heightTextField.borderStyle = UITextBorderStyleLine;
        _heightTextField.placeholder = @"请输入高度";
    }
    return _heightTextField;
}
@end
