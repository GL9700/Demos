//
//  RowsViewController.h
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface RowsViewController : UIViewController
@property (nonatomic) void(^onHandleConfirm)(BookModel *model);
@property (nonatomic) void(^onHandleCancel)(void);
@property (nonatomic) BOOL isEdit;
@property (nonatomic) NSArray *datasource;
@end
