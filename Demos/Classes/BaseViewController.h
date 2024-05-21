//
//  BaseViewController.h
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, readonly) UIStackView *stackView;
- (UIButton *)ButtonWithTitle:(NSString *)title action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
