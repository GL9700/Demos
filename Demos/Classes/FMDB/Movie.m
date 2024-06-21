//
//  Movie.m
//  Demos
//
//  Created by liguoliang on 2024/5/21.
//

#import "Movie.h"

@implementation Movie
- (NSString *)tableName {
    return @"t_movie";
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
