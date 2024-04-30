//
//  BookModel.h
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import <Foundation/Foundation.h>
#import <WCDBObjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject <WCTTableCoding>
@property (nonatomic) NSString *name;   // 书名
@property (nonatomic) NSString *author; // 作者
@property (nonatomic) NSString *isbn;   // ISBN
@property (nonatomic) NSInteger price;  // 价格
@property (nonatomic) NSTimeInterval createTime;
@property (nonatomic) NSTimeInterval updateTime;
WCDB_PROPERTY(name);
WCDB_PROPERTY(author);
WCDB_PROPERTY(isbn);
WCDB_PROPERTY(price);
WCDB_PROPERTY(createTime);
WCDB_PROPERTY(updateTime);
@end

NS_ASSUME_NONNULL_END
