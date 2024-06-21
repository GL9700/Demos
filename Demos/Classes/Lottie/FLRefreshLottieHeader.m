//
//  FLRefreshLottieHeader.m
//  ShortPlay
//
//  Created by liguoliang on 2024/2/5.
//  Copyright © 2024 FeiLu. All rights reserved.
//

#import "FLRefreshLottieHeader.h"
#import <AudioToolbox/AudioToolbox.h>
#import <Lottie/Lottie.h>


@interface FLRefreshLottieHeader ()
@property(nonatomic, strong) LOTAnimationView *loadingView;
@property(nonatomic, strong) NSString *jsonString;
@end

@implementation FLRefreshLottieHeader

- (instancetype)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	self.lastUpdatedTimeLabel.hidden = YES;
	self.stateLabel.hidden = YES;
}

- (LOTAnimationView *)loadingView {
	if (!_loadingView) {
		_loadingView = [LOTAnimationView animationNamed:self.jsonString];
		_loadingView.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2 - 50, 0, 100, 50);
		_loadingView.loopAnimation = YES;
		_loadingView.contentMode = UIViewContentModeScaleAspectFill;
		_loadingView.animationSpeed = 1.0;
	}
	return _loadingView;
}

+ (instancetype)refreshWithJsonName:(NSString *)name handle:(void(^)(void))block {
	FLRefreshLottieHeader *header = [FLRefreshLottieHeader new];
	header.jsonString = name;
	[header addSubview:header.loadingView];
	if(block) {
		header.refreshingBlock = block;
	}
	return header;
}

#pragma mark - innerMethod
- (void)beginRefreshing {
	if (@available(iOS 10.0, *)) {
		UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
		[impactLight impactOccurred];
	} else {
		AudioServicesPlaySystemSound(1502);
	}
	[super beginRefreshing];
}

#pragma mark - 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
	MJRefreshCheckState;
	if (self.jsonString.length > 0) {
		switch (state) {
			case MJRefreshStateIdle: {
				[self.loadingView stop];
				break;
			}
			case MJRefreshStatePulling: {
				break;
			}
			case MJRefreshStateRefreshing: {
				self.loadingView.animationProgress = 0;
				[self.loadingView play];
				break;
			}
			default:
				break;
		}
	}
}

#pragma mark - 实时监听控件 scrollViewContentOffset
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
	[super scrollViewContentOffsetDidChange:change];
	if (self.jsonString.length > 0) {
		CGPoint point;
		id newVelue = [change valueForKey:NSKeyValueChangeNewKey];
		[(NSValue *)newVelue getValue:&point];
		
		self.loadingView.hidden = !(self.pullingPercent);
		CGFloat progress = point.y / (CGRectGetWidth([UIScreen mainScreen].bounds)/3.0);
		if (self.state != MJRefreshStateRefreshing) {
			self.loadingView.animationProgress = -progress;
		}
	}
}
@end
