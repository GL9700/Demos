//
//  IDBEntity.h
//  Demos
//
//  Created by liguoliang on 2024/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDBEntity <NSObject>
@required
/// 表名
- (NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
