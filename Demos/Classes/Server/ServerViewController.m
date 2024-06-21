//
//  ServerViewController.m
//  Demos
//
//  Created by liguoliang on 2024/6/21.
//

#import "ServerViewController.h"
#import <WebKit/WebKit.h>

#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>
#import <GCDWebServerStreamedResponse.h>

#import <SRWebSocket.h>

@interface ServerViewController () <GCDWebServerDelegate, SRWebSocketDelegate>
@property (nonatomic) NSDateFormatter *format;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@property (weak, nonatomic) IBOutlet UITextField *protTextField;
@property (nonatomic) GCDWebServer *webserver;
@property (nonatomic) SRWebSocket *websocket;
@property (nonatomic) NSURL *serverURL;
@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stackView.hidden = YES;
    
    // 创建并配置 WebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self onClickStopButton:nil];
}

// MARK: - upgrade service
- (IBAction)onClickUpgradeButton:(UIButton *)sender {
    [self.websocket open];
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [self insertMsg:SF(@"socket 升级成功 >> %@", webSocket.url.absoluteString)];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self insertMsg:SF(@"socket 发生错误 >> %@", error)];
    [webSocket close];
    _websocket = nil;
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self insertMsg:SF(@"socket 关闭 >> code:%ld reason:%@",(long)code, reason)];
}

// MARK: - Http server
- (IBAction)onClickStartButton:(UIButton *)sender {
    if([self.webserver isRunning]){
        [self insertMsg:@"http 服务重启中"];
        [self.webserver stop];
    }else{
        [sender setTitle:@"restart" forState:UIControlStateNormal];
    }
    [self.webserver startWithPort: [self.protTextField.text integerValue] bonjourName:nil];
}
- (IBAction)onClickStopButton:(UIButton *)sender {
    if([self.webserver isRunning]){
        [self.webserver stop];
    }
}

- (void)webServerDidStart:(GCDWebServer*)server {
    self.serverURL = server.serverURL;
    [self insertMsg:SF(@"http 服务启动 >> %@", server.serverURL.absoluteString)];
}
- (void)webServerDidConnect:(GCDWebServer *)server {
    [self insertMsg:@"...收到请求"];
}
- (void)webServerDidDisconnect:(GCDWebServer *)server {
    [self insertMsg:@"...断开请求"];
}
- (void)webServerDidStop:(GCDWebServer *)server {
    [self insertMsg:@"http 服务结束"];
}

// MARK: - other
- (SRWebSocket *)websocket {
    if(!_websocket) {
        NSURLComponents *comp = [NSURLComponents componentsWithURL:self.serverURL resolvingAgainstBaseURL:self.serverURL];
//        comp.scheme = @"ws";
        NSLog(@"%@", comp.URL.absoluteString);
        if(comp.URL!=nil) {
            _websocket = [[SRWebSocket alloc] initWithURL:comp.URL];
            _websocket.delegate = self;
        }
    }
    return _websocket;
}
- (GCDWebServer *)webserver {
    if(!_webserver) {
        _webserver = [[GCDWebServer alloc] init];
        _webserver.delegate = self;
        /** 同步 */
        [_webserver addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
            NSLog(@"%@", request);
            return [GCDWebServerDataResponse responseWithHTML:@"<html><body><div><h2>Hello</h2></div></body></html>"];
        }];
        /** 分批异步返回
        [_webserver addDefaultHandlerForMethod:@"GET" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
            // 建立数据列表
            NSMutableArray* contents = [NSMutableArray arrayWithObjects:@"<html><body><p>\n", @"Hello World!\n", @"</p></body></html>\n", nil];
            GCDWebServerStreamedResponse *streamedResp = [GCDWebServerStreamedResponse responseWithContentType:@"text/html" asyncStreamBlock:^(GCDWebServerBodyReaderCompletionBlock completionBlock) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSString* string = contents.firstObject;
                    if (string) {
                        [contents removeObjectAtIndex:0];
                        completionBlock([string dataUsingEncoding:NSUTF8StringEncoding], nil);  // 按照队列发送数据，completionBlock 会继续响应
                    } else {
                        completionBlock([NSData data], nil);    // 发送空内容，以结束响应
                    }
                });
            }];
            return streamedResp;
        }];
         */
    }
    return _webserver;
}
- (void)insertMsg:(NSString *)msg {
    NSString *time = [self.format stringFromDate:[NSDate date]];
    NSMutableString *str = [NSMutableString stringWithString:self.outputTextView.text];
    if(str.length>0) {
        [str appendString:@"\n"];
    }
    [str appendFormat:@"[%@]%@", time, msg];
    self.outputTextView.text = [str copy];
}
- (NSDateFormatter *)format {
    if(!_format) {
        _format = [NSDateFormatter new];
        _format.dateFormat = @"HH:mm:ss";
    }
    return _format;
}
@end
