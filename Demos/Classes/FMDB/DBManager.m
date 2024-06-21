//
//  DBManager.m
//  Demos
//
//  Created by liguoliang on 2024/5/21.
//

#import "DBManager.h"
#import <FMDB/FMDB.h>
#import <objc/message.h>

@interface DBManager()
@property (nonatomic) FMDatabaseQueue *dbq;
@end

@implementation DBManager
+ (instancetype)Shared {
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc] init];
    });
    return manager;
}

- (NSArray *)getPropertyListFromClass:(Class)cls {
    NSMutableArray *props = [@[] mutableCopy];
    uint count = 0;
    objc_property_t *p = class_copyPropertyList(cls, &count);
    for(int i=0;i<count;i++) {
        NSString *var = [NSString stringWithCString:property_getName(p[i]) encoding:NSUTF8StringEncoding];
        if([[NSString stringWithCString:property_getAttributes(p[i]) encoding:NSUTF8StringEncoding] hasSuffix:SF(@"V_%@", var)]) {
            [props addObject:var];
        }
    }
    return [props copy];
}
- (NSString *)getTableNameFromEntity:(id<IDBEntity>)model {
    if([model respondsToSelector:@selector(tableName)]) {
        return [model tableName];
    }
    return nil;
}

- (BOOL)openDatabaseWithPath:(NSString *)path {
    self.dbq = [[FMDatabaseQueue alloc] initWithPath:path];
    return (BOOL)[self.dbq openFlags];
}
- (void)createTableName:(NSString *)name withClass:(Class)cls {
    NSMutableArray *props = [[self getPropertyListFromClass:cls] mutableCopy];
    for (int i=0;i<props.count;i++) {
        props[i] = SF(@"%@ %@", props[i]);
    }
    NSString *sql = SF(@"TABLE IF NOT EXISTS %@(%@)", name, props);
    [self.dbq inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeQuery:sql];
    }];
}

- (BOOL)insertObjectWithModel:(id<IDBEntity>)model {
    NSArray *arr = [self getPropertyListFromClass:model.class];
    NSString *tab_name = [self getTableNameFromEntity:model];
    
    return YES;
}


@end
