//
//  WCDBCenter.m
//  Demos
//
//  Created by liguoliang on 2024/5/17.
//

#import "WCDBCenter.h"
#import <WCDB/WCDB.h>

@interface WCDBCenter()
@property (nonatomic, readwrite) NSString *path; // 路径
@property (nonatomic, readwrite) BOOL isExist;   // 是否存在
@property (nonatomic, readwrite) BOOL isNormal;  // 是否正常
@property (nonatomic) WCTDatabase *database;
@end

@implementation WCDBCenter
+ (instancetype)SharedWithPath:(NSString *)dbPath {
    static WCDBCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCDBCenter alloc] initWithPath:dbPath];
    });
    return instance;
}
- (instancetype)initWithPath:(NSString *)dbPath {
    if((self = [super init])) {
        self.path = dbPath;
        if(self.path==nil) {
            self.path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"app.sqlite"];
            [self isExist];
            self.database = [[WCTDatabase alloc] initWithPath:self.path];
        }
    }
    return self;
}
- (BOOL)createTable:(NSString *)name EntityClass:(Class)entityClass {
    return [self.database createTable:name withClass:entityClass];
}
- (BOOL)isExist {
    if([[NSFileManager defaultManager] fileExistsAtPath:self.path]) {
        return YES;
    }else{
        [[NSFileManager defaultManager] createDirectoryAtPath:[self.path stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        return NO;
    }
}
- (BOOL)isNormal {
    return [self.database rawExecute:@"PRAGMA integrity_check"];
}
@end
@implementation WCDBCenter (DML)
- (BOOL)execut:(NSString *)sql {
    return NO;
}
- (BOOL)insertEntity:(id)entity into:(NSString *)tableName {
    return NO;
}
- (BOOL)deleteRowWhereEntity:(id)entity from:(NSString *)tableName {
    return NO;
}
- (BOOL)updateRowEntity:(id)entity whereEntity:(id)entity  into:(NSString *)tableName {
    return NO;
}
- (NSArray<id> *)selectRowsWhereEntity:(id)entity from:(NSString *)tableName {
    return nil;
}

@end
