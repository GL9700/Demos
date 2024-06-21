//
//  WebsocketViewController.m
//  Demos
//
//  Created by liguoliang on 2024/6/20.
//

#import "WebsocketViewController.h"
#import <SRWebSocket.h>
#import <UIColor+GLExtension.h>

@interface WebsocketViewController ()<SRWebSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *connURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *connButton;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *outTextView;
@property (nonatomic) SRWebSocket *socket;
@property (nonatomic) NSDateFormatter *format;
@property (nonatomic) BOOL isConn;
@end

@implementation WebsocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.stackView setHidden:YES];
    self.connURLTextField.text = @"ws://192.168.1.59:8088/ws?id=10086";
    self.inputTextView.layer.borderWidth = 1;
    self.inputTextView.layer.borderColor = [[UIColor colorFromHexValue:0x666666] CGColor];
    self.inputTextView.layer.cornerRadius = 5.f;
    self.inputTextView.layer.masksToBounds = YES;
    self.outTextView.layer.borderWidth = 1;
    self.outTextView.layer.borderColor = [[UIColor colorFromHexValue:0x666666] CGColor];
    self.outTextView.layer.cornerRadius = 5.f;
    self.outTextView.layer.masksToBounds = YES;
}

- (IBAction)onClickConnButton:(UIButton *)sender {
    if(self.isConn==NO){
        [self insertMsg:@"开始连接"];
        self.socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:self.connURLTextField.text]];
        self.socket.delegate = self;
        [self.socket open];
    }else{
        [self.socket close];
    }
}
- (IBAction)onClickSendButton:(UIButton *)sender {
    
}


- (void)insertMsg:(NSString *)msg {
    NSString *time = [self.format stringFromDate:[NSDate date]];
    NSMutableString *str = [NSMutableString stringWithString:self.outTextView.text];
    if(str.length>0) {
        [str appendString:@"\n"];
    }
    [str appendFormat:@"[%@]%@", time, msg];
    self.outTextView.text = [str copy];
}
- (NSDateFormatter *)format {
    if(!_format) {
        _format = [NSDateFormatter new];
        _format.dateFormat = @"HH:mm:ss";
    }
    return _format;
}

// MARK: - srwebsocket delegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data {
    
}
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [self insertMsg:@"连接成功"];
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self insertMsg:[NSString stringWithFormat:@"连接失败 %@", [error description]]];
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean {
    [self insertMsg:[NSString stringWithFormat:@"连接关闭 %@", reason]];
}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePingWithData:(nullable NSData *)data {
    
}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(nullable NSData *)pongData {
    
}

- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket {
    return YES;
}
@end
