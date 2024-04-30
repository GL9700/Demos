//
//  WCDBHome.m
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import "WCDBHome.h"
#import <WCDBObjc.h>
#import "BookModel.h"
#import "RowsViewController.h"

@interface WCDBHome ()
@property (nonatomic) WCTDatabase *database;
@end

@implementation WCDBHome

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = @[
        @{@"title":@"初始化数据库"},
        @{@"title":@"创建表"},
        @{@"title":@"插入数据"},
        @{@"title":@"查询数据"},
        @{@"title":@"更新数据"},
        @{@"title":@"删除数据"},
        @{@"title":@"删除表"},
        @{@"title":@"删除数据库"}
    ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.datasource[indexPath.row][@"title"];
    if([title isEqualToString:@"初始化数据库"]) {
        [self initDatabaseWithIndexPath:indexPath];
    } else if([title isEqualToString:@"创建表"]) {
        [self createTableWithIndexPath:indexPath];
    } else if([title isEqualToString:@"插入数据"]) {
        [self insertDataWithIndexPath:indexPath];
    } else if([title isEqualToString:@"查询数据"]) {
        [self queryDataWithIndexPath:indexPath];
    } else if([title isEqualToString:@"更新数据"]) {
        [self updateDataWithIndexPath:indexPath];
    } else if([title isEqualToString:@"删除数据"]) {
        [self deleteDataWithIndexPath:indexPath];
    } else if([title isEqualToString:@"删除表"]) {
        [self deleteTableWithIndexPath:indexPath];
    } else if([title isEqualToString:@"删除数据库"]) {
        [self deleteDatabaseWithIndexPath:indexPath];
    }
}
// 初始化并打开数据库(如果没有则创建)
- (void)initDatabaseWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"wcdb_home.db"];
    klog(path);
    self.database = [[WCTDatabase alloc] initWithPath:path];
    if(self.database) {
        klog(@"数据库初始化成功");
        [self updateCellState:ResultStatusSuccess WithIndexPath:indexPath];
    } else {
        klog(@"数据库初始化失败");
        [self updateCellState:ResultStatusFailed WithIndexPath:indexPath];
    }
    [self.database canOpen] ? klog(@"数据库打开成功") : klog(@"数据库打开失败");
}
// 创建表
- (void)createTableWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    BOOL suc = [self.database createTable:@"BookModel" withClass:BookModel.class];
    if(suc) {
        klog(@"创建表成功");
        [self updateCellState:ResultStatusSuccess WithIndexPath:indexPath];
    } else {
        klog(@"创建表失败");
        [self updateCellState:ResultStatusFailed WithIndexPath:indexPath];
    }
}

// 插入数据
- (void)insertDataWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    RowsViewController *row = [[RowsViewController alloc] init];
    row.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:row animated:YES completion:nil];
    row.onHandleConfirm = ^(BookModel *model) {
        
    };
    row.onHandleCancel = ^{
        
    };
}

// 查询数据
- (void)queryDataWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    
}
// 更新数据
- (void)updateDataWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    
}
// 删除数据
- (void)deleteDataWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    
}
// 删除表
- (void)deleteTableWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    
}
// 删除数据库
- (void)deleteDatabaseWithIndexPath:(NSIndexPath *)indexPath {
    [self updateCellState:ResultStatusProcessing WithIndexPath:indexPath];
    
}

@end
