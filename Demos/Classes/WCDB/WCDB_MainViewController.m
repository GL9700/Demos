//
//  WCDB_MainViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/17.
//

#import "WCDB_MainViewController.h"
#import "WCDBCenter.h"
#import "ModelEntity.h"

@interface WCDB_MainViewController ()
@end

@implementation WCDB_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UIButton *createbutton = [self ButtonWithTitle:@"创建数据库" action:@selector(onClickCreateDB:)];
    [self.stackView addArrangedSubview:createbutton];
}

- (void)onClickCreateDB:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    BOOL suc = NO;
    WCDBCenter *dbc = [WCDBCenter SharedWithPath:nil];
    suc = [dbc createTable:@"t_user_1" EntityClass:ModelEntity.class];
    if(suc){
        [sender setTitle:SF(@"✅ %@", title) forState:UIControlStateNormal];
    }else{
        [sender setTitle:SF(@"🔄 %@", title) forState:UIControlStateNormal];
    }
    NSLog(@"路径:%@", dbc.path);
}

@end
