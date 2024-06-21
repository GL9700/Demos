//
//  FLRefreshLottieHeader.h
//  ShortPlay
//
//  Created by liguoliang on 2024/2/5.
//  Copyright © 2024 FeiLu. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLRefreshLottieHeader : MJRefreshGifHeader
+ (instancetype)refreshWithJsonName:(NSString *)name handle:(void(^)(void))block ;
@end

NS_ASSUME_NONNULL_END
