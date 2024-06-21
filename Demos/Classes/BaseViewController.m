//
//  BaseViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import "BaseViewController.h"
#import "FLLottieView.h"

@interface BaseViewController ()
@property (nonatomic, readwrite) UIStackView *stackView;
@property (nonatomic) FLLottieView *lotView;
@end

@implementation BaseViewController

- (void)routerParams:(NSDictionary *)params {
    self.title = params[@"title"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}
- (UIButton *)ButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UIStackView *)stackView {
    if(!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = 10;
    }
    return _stackView;
}

- (void)loadingShow {
    self.view.userInteractionEnabled = NO;
    if(!self.lotView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.lotView];
    }
    self.lotView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2);
    [self.view bringSubviewToFront:self.lotView];
    [self.lotView play];
    self.lotView.hidden = NO;
}

- (void)loadingHide {
    self.view.userInteractionEnabled = YES;
    self.lotView.hidden = YES;
    [self.lotView stop];
}
- (FLLottieView *)lotView {
    if(!_lotView) {
        _lotView = [FLLottieView LoadJsonForName:@"loading"];
        _lotView.frame = CGRectMake(0, 0, 128, 128);
        [_lotView loop:YES];
    }
    return _lotView;
}
- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}
@end
