//
//  WCDBCenter.h
//  Demos
//
//  Created by liguoliang on 2024/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCDBCenter<T> : NSObject
@property (nonatomic, readonly) NSString *path; // 路径
@property (nonatomic, readonly) BOOL isExist;   // 是否存在
@property (nonatomic, readonly) BOOL isNormal;  // 是否正常

/// 单例
+ (instancetype)SharedWithPath:(NSString *)dbPath;

/// 创建表
/// - Parameters:
///   - name: 表名
///   - entityClass: ORM映射
- (BOOL)createTable:(NSString *)name EntityClass:(Class)entityClass;

@end

@interface WCDBCenter<T>(DML)
- (BOOL)execut:(NSString *)sql;
/// 增
- (BOOL)insertEntity:(T)entity into:(NSString *)tableName;
/// 删
- (BOOL)deleteRowWhereEntity:(T)entity from:(NSString *)tableName;
/// 改
- (BOOL)updateRowEntity:(T)entity whereEntity:(T)entity  into:(NSString *)tableName;
/// 查
- (NSArray<T> *)selectRowsWhereEntity:(T)entity from:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
