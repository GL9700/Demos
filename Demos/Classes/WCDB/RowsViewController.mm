//
//  RowsViewController.m
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import "RowsViewController.h"

@interface RowsViewController ()
@property (nonatomic) UIScrollView *scroller;
@property (nonatomic) UIView *contentView;
@end

@implementation RowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.contentView = [UIView new];
    [self.scroller addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scroller);
        make.height.equalTo(self.scroller);
    }];
 
    if (self.datasource.count==0) {
        self.isEdit = true;
        self.datasource = @[[self createModelViewWithModel:nil]];
    }
}

- (UIView *)createModelViewWithModel:(BookModel *)model {
    UIView *boxView = [[UIView alloc] init];
    boxView.backgroundColor = [UIColor whiteColor];
    boxView.layer.cornerRadius = 5;
    boxView.layer.shadowColor = [UIColor blackColor].CGColor;
    boxView.layer.shadowOffset = CGSizeMake(0, 0);
    boxView.layer.shadowOpacity = 0.5;
    boxView.layer.shadowRadius = 5;
    [self.contentView addSubview:boxView];
    return boxView;
}

- (NSArray *)datasource {
    if(!_datasource) {
        _datasource = [NSArray array];
    }
    return _datasource;
}

- (UIScrollView *)scroller {
    if (!_scroller) {
        _scroller = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scroller.pagingEnabled = YES;
        [self.view addSubview:_scroller];
    }
    return _scroller;
}
@end
