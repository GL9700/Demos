//
//  DBManager.h
//  Demos
//
//  Created by liguoliang on 2024/5/21.
//

#import <Foundation/Foundation.h>
#import "IDBEntity.h"
NS_ASSUME_NONNULL_BEGIN


@interface DBManager : NSObject
+ (instancetype)Shared;

/// 如果没有则创建并使用
- (BOOL)openDatabaseWithPath:(NSString *)path;

/// 创建表(通过Model)
- (void)createTableWithName:(NSString *)name;

/// 增
- (BOOL)insertObjectWithModel:(id<IDBEntity>)model;

/// 删
- (BOOL)deleteObjectWhere:(NSString *(^)(void))whereHandle;

/// 改
- (BOOL)updateObjectWhere:(NSString *(^)(void))whereHandle;

/// 查
- (NSInteger)selectCountWhere:(NSString *(^)(void))whereHandle;
- (NSArray *)selectObjectWhere:(NSString *(^)(void))whereHandle;

@end

NS_ASSUME_NONNULL_END
