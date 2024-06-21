//
//  Movie.h
//  Demos
//
//  Created by liguoliang on 2024/5/21.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "IDBEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject <IDBEntity>
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *director;
@property (nonatomic) NSArray<User *> *actors;
@property (nonatomic) NSDate *releaseDate;
@property (nonatomic) NSTimeInterval duration;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
