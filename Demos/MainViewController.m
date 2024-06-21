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
    self.title = @"MainViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [GLRouterManager failure:^(NSError *error, NSString *detail) {
        showToastMsg(@"[GLRouter Error]: %@, detail: %@", error, detail);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
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
    NSString *title = self.datasource[indexPath.row][@"title"];
    void(^blk)(void) = self.datasource[indexPath.row][@"block"];
    if(blk) {
        blk();
    }
    else if(class) {
        rto_dsp([NSString stringWithFormat:@"d://push/%@?%@", class, title], nil);
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
        @{
            @"title":@"WebView",
            @"class":@"WebViewController",
            @"subtitle":@"有进度的网页ViewController",
            @"block":^(void){
                rto_dsp(@"d://push/WebViewController?title=WebView&url=https://cn.vuejs.org", nil);
            }
        },
        @{
            @"title":@"AI : NaturalLanguage",
            @"class":@"AI_NL_ViewController",
            @"subtitle":@"ai 自然语言分析"
        },
        @{
            @"title":@"AI : NaturalLanguage - 2",
            @"class":@"AI_NL_2_ViewController",
            @"subtitle":@"ai 自然语言分析 - 2"
        },
        @{
            @"title":@"FMDB数据库",
            @"class":@"FMDB_ViewController",
            @"subtitle":@"fmdb数据库"
        },
        @{
            @"title":@"弹出自动高度ViewController",
            @"class":@"PresentHalf_ViewController",
            @"subtitle":@"自动高度"
        },
        @{
            @"title":@"Websocket",
            @"class":@"WebsocketViewController",
            @"subtitle":@"websocket"
        },
        @{
            @"title":@"Server",
            @"class":@"ServerViewController",
            @"subtitle":@"http server for iOS"
        }
    ];
}

@end
