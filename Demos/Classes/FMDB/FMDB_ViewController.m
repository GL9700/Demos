//
//  FMDB_ViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/20.
//

#import "FMDB_ViewController.h"
#import "Movie.h"
#import "DBManager.h"

@interface FMDB_ViewController ()
@property (nonatomic) DBManager *db;
@property (nonatomic) NSArray<Movie *> *movies;
@end

@implementation FMDB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [self datas];
    [self.db insertObjectWithModel:arr[0]];
    NSLog(@"11");
}

- (NSArray *)datas {
    return @[
        [[Movie alloc] initWithDictionary:@{
            @"name":@"让子弹飞",
            @"desc":@"让子弹飞一会儿",
            @"director":@"姜文",
            @"releaseDate":[NSDate date],
            @"duration":@7200
        }],
    ];
}

- (DBManager *)db {
    if(!_db) {
        _db = [DBManager Shared];
    }
    return _db;
}

@end
