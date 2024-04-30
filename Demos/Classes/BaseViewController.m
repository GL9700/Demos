//
//  BaseViewController.m
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITextView *textView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSDictionary *dict = self.datasource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.detailTextLabel.text = dict[@"subtitle"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)updateCellState:(ResultStatus)status WithIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    switch(status){
        case ResultStatusProcessing:
            cell.accessoryView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [(UIActivityIndicatorView *)cell.accessoryView startAnimating];
            break;
        case ResultStatusSuccess:
            cell.accessoryView = [UILabel new];
            [(UILabel *)cell.accessoryView setText:@"✅"];
            [(UILabel *)cell.accessoryView sizeToFit];
            break;
        case ResultStatusFailed:
            cell.accessoryView = [UILabel new];
            [(UILabel *)cell.accessoryView setText:@"⚠️"];
            [(UILabel *)cell.accessoryView sizeToFit];
            break;
        default:
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
    }
}
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)logMsg:(NSString *)msg {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss.SSS";
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *log = [NSString stringWithFormat:@"[%@] %@\n", dateStr, msg];
    self.textView.text = [self.textView.text stringByAppendingString:log];
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}
- (UITextView *)textView {
    if(!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.editable = NO;
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.view addSubview:_textView];
        _textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _textView;
}
@end
