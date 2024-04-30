//
//  MainViewController.m
//  Demos
//
//  Created by liguoliang on 2024/4/30.
//

#import "MainViewController.h"


@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MainViewController";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [GLRouterManager failure:^(NSError *error, NSString *detail) {
        showToastMsg(@"[GLRouter Error]: %@, detail: %@", error, detail);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self datasource] count];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld", section];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.1;
    animation.fromValue = @(1.0);
    animation.toValue = @(0.95);
    animation.autoreverses = YES;
    [cell.layer addAnimation:animation forKey:nil];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *class = self.datasource[indexPath.row][@"class"];
    if(class) {
        rto_dsp([NSString stringWithFormat:@"d://push/%@", class], nil);
    }
}
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)datasource {
    return @[
        @{@"title":@"WCDB", @"class":@"WCDBHome", @"subtitle":@"腾讯的sqlite，效率比FMDB高"}
    ];
}

@end
