//
//  FLLottieView.m
//  ShortPlay
//
//  Created by liguoliang on 2024/2/5.
//  Copyright © 2024 FeiLu. All rights reserved.
//

#import "FLLottieView.h"
#import <Lottie.h>

@interface FLLottieView()
@property (nonatomic) LOTAnimationView *animationView;
@property (nonatomic) BOOL loop;
@end

@implementation FLLottieView

+ (instancetype)LoadJsonForName:(NSString *)name {
	FLLottieView *flv = [FLLottieView new];
	NSURL *jsonURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"json"];
	if(jsonURL){
		flv.animationView = [[LOTAnimationView alloc] initWithContentsOfURL:jsonURL];
		[flv addSubview:flv.animationView];
	}
	return flv;
}

- (void)loop:(BOOL)loop {
	_loop = loop;
	self.animationView.loopAnimation = _loop;
}
- (void)play {
	[self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	[self.animationView play];
}
- (void)stop {
	[self.animationView stop];
}
- (void)speed:(float)speed {
	self.animationView.animationSpeed = speed;
}
@end
