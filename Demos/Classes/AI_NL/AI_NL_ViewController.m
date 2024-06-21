//
//  AI_NL_ViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/27.
//

#import "AI_NL_ViewController.h"
#import <NaturalLanguage/NaturalLanguage.h>

@interface AI_NL_ViewController ()
@property (nonatomic) NLTokenizer *tokenizer;
@property (nonatomic) NSString *stringWithArticle;
@property (nonatomic) UITextView *inputTextView;
@property (nonatomic) UIButton *runButton;
@property (nonatomic) UITextView *outputTextView;
@end

@implementation AI_NL_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.runButton];
    [self.runButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.height.equalTo(@40);
        make.top.equalTo(self.stackView.mas_bottom).offset(15);
    }];
    
    [self.stackView addArrangedSubview:self.inputTextView];
    [self.stackView addArrangedSubview:self.outputTextView];
    
    [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    self.inputTextView.text = self.stringWithArticle;
}

- (void)startRun:(UIButton *)sender {
    [self loadingShow];
    self.tokenizer.string = self.stringWithArticle;
    NSRange range = NSMakeRange(0, self.stringWithArticle.length-1);
    NSMutableArray *context = [NSMutableArray array];
    [self.tokenizer enumerateTokensInRange:range usingBlock:^(NSRange tokenRange, NLTokenizerAttributes flags, BOOL * _Nonnull stop) {
        NSString *word = [self.stringWithArticle substringWithRange:tokenRange];
        [context addObject:[self workInfo:word type:flags]];
        if(tokenRange.length + tokenRange.location >= self.stringWithArticle.length-1) {
            [self loadingHide];
            [self endCheckWithContext:[context copy]];
        }
    }];
}
- (NSString *)workInfo:(NSString *)str type:(NLTokenizerAttributes)type {
    NSString *t = @"文字";
    if(type == NLTokenizerAttributeNumeric) {
        t = @"数字";
    } else if(type == NLTokenizerAttributeSymbolic) {
        t = @"符号";
    } else if(type == NLTokenizerAttributeEmoji) {
        t = @"表情";
    }
    return [NSString stringWithFormat:@"[%@(%@)]", str, t];
}

- (void)endCheckWithContext:(NSArray *)arr {
    self.outputTextView.text = [arr componentsJoinedByString:@","];
}

- (NLTokenizer *)tokenizer {
    if(!_tokenizer) {
        _tokenizer = [[NLTokenizer alloc] initWithUnit:NLTokenUnitWord];
    }
    return _tokenizer;
}
- (NSString *)stringWithArticle {
    return @"新华社北京5月26日电:近日，国家主席习近平复信阿联酋中文教学“百校项目”学生代表，勉励他们学好中文、了解中国，为促进中阿友好贡献力量。习近平表示，我读了你们每个人的信，从字里行间、画里画外感受到了大家对中国文化的热爱，对两国友好的期盼。5年前，我同穆罕默德总统共同启动阿联酋中文教学“百校项目”，如今看到“学中文”在阿联酋已经成为一种新风尚，培养了一批像你们这样的中阿交流小使者，我很欣慰。习近平指出，你们在信中说，中国和阿联酋“手拉手”40年了，希望中阿永远是好朋友，中国人民也抱有同样的愿望。青少年代表着中阿友好关系的未来。欢迎你们来中国看熊猫、登长城，长大后到中国读大学，也欢迎更多的阿联酋青少年学习中文、了解中国，同中国的青少年交流交心、互学互鉴，把友谊的种子根植在心里，为开创中阿关系更加美好的明天贡献力量。2019年7月，在习近平主席和时任阿联酋阿布扎比王储穆罕默德共同见证下，中阿双方在北京签署备忘录，正式启动阿联酋中文教学“百校项目”。截至目前，阿联酋已有171所学校开设中文课程，7.1万名学生学习中文。近日，阿联酋“百校项目”示范校哈姆丹学校和亚斯学校40名中小学生代表分别用中文致信习主席，表达对中国文化的向往和热爱，立志做中阿友好的使者。";
}
- (UIButton *)runButton {
    if(!_runButton) {
        _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_runButton setTitle:@"Run" forState:UIControlStateNormal];
        [_runButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_runButton addTarget:self action:@selector(startRun:) forControlEvents:UIControlEventTouchUpInside];
        _runButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _runButton.titleLabel.textColor = [UIColor blackColor];
    }
    return _runButton;
}
- (UITextView *)inputTextView {
    if(!_inputTextView) {
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _inputTextView.layer.borderWidth = 1;
        _inputTextView.font = [UIFont systemFontOfSize:13];
        _inputTextView.textColor = [UIColor blackColor];
        _inputTextView.text = @"input";
    }
    return _inputTextView;
}
- (UITextView *)outputTextView {
    if(!_outputTextView) {
        _outputTextView = [[UITextView alloc] init];
        _outputTextView.backgroundColor = [UIColor whiteColor];
        _outputTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _outputTextView.layer.borderWidth = 1;
        _outputTextView.font = [UIFont systemFontOfSize:13];
        _outputTextView.textColor = [UIColor lightGrayColor];
        _outputTextView.text = @"output:\n";
    }
    return _outputTextView;
}
@end
