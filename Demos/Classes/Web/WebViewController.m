//
//  WebViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/16.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController () <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) NSString *url;
@end

@implementation WebViewController

- (void)routerParams:(NSDictionary *)params {
    self.url = params[@"url"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self secureScreenShot:YES handle:^UIImage *(UIImage *screenShotImage) {
//        return [UIImage imageNamed:@"face5"];
//    }];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
    [self requestWeb];
}

- (void)userDidScreenshot:(NSNotification *)notification {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.image = [UIImage imageNamed:@"face5"];
    showToastMsg(@"拷贝成功");
}

- (void)requestWeb {
    if(self.url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        if(req){
            [self.webView loadRequest:req];
            return;
        }
    }
    showToastMsg(@"URL Error : %@", self.url);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self updateProgressWithNavigation:navigation];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self updateProgressWithNavigation:navigation];
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    [self updateProgressWithNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self updateProgressWithNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self updateProgressWithNavigation:navigation];
}

- (void)updateProgressWithNavigation:(WKNavigation *)navigation {
    if (navigation && self.webView.isLoading) {
        float progress = self.webView.estimatedProgress;
        [self.progressView setProgress:progress animated:YES];
        self.progressView.hidden = NO;
    } else {
        [self.progressView setProgress:1.0 animated:YES];
        self.progressView.hidden = YES;
    }
}



- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.allowsBackForwardNavigationGestures = YES;
//        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _webView;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor lightGrayColor];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}
@end
