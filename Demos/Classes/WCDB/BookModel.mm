//
//  BookModel.m
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import "BookModel.h"

@implementation BookModel
WCDB_IMPLEMENTATION(BookModel);

WCDB_SYNTHESIZE(name);
WCDB_SYNTHESIZE(author);
WCDB_SYNTHESIZE(isbn);
WCDB_SYNTHESIZE(price);
WCDB_SYNTHESIZE(createTime);
WCDB_SYNTHESIZE(updateTime);
@end
