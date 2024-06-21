//
//  FLLottieView.h
//  ShortPlay
//
//  Created by liguoliang on 2024/2/5.
//  Copyright © 2024 FeiLu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLLottieView : UIView
+ (instancetype)LoadJsonForName:(NSString *)name;
- (void)loop:(BOOL)loop;
- (void)play;
- (void)stop;
- (void)speed:(float)speed;
@end

NS_ASSUME_NONNULL_END
