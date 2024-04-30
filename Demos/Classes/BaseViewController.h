//
//  BaseViewController.h
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import <UIKit/UIKit.h>

#define klog(__msg__) [self logMsg:__msg__]

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ResultStatusNone,
    ResultStatusProcessing,
    ResultStatusSuccess,
    ResultStatusFailed
} ResultStatus;

@interface BaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSArray<NSDictionary *> * datasource;
- (void)updateCellState:(ResultStatus)status WithIndexPath:(NSIndexPath *)indexPath;
- (void)logMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
