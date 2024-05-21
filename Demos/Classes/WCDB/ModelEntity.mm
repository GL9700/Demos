//
//  ModelEntity.m
//  Demos
//
//  Created by liguoliang on 2024/5/17.
//

#import "ModelEntity.h"
#import <WCDBObjc.h>

@interface ModelEntity() < WCTTableCoding >
@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *content;

WCDB_PROPERTY(identifier)
WCDB_PROPERTY(name)
WCDB_PROPERTY(content)

@end

@implementation ModelEntity

WCDB_IMPLEMENTATION(ModelEntity)
WCDB_SYNTHESIZE(identifier)
WCDB_SYNTHESIZE(name)
WCDB_SYNTHESIZE(content)

@end
