//
//  AI_NL_2_ViewController.m
//  Demos
//
//  Created by liguoliang on 2024/5/27.
//

#import "AI_NL_2_ViewController.h"
#import <NaturalLanguage/NaturalLanguage.h>

@interface AI_NL_2_ViewController ()

@property (nonatomic) NLLanguageRecognizer *recognizer;
@property (nonatomic) NLTagger *tagger;

@property (nonatomic) NSString *stringWithArticle;
@property (nonatomic) UITextView *inputTextView;
@property (nonatomic) UIButton *runButton;
@property (nonatomic) UIButton *clearButton;
@property (nonatomic) UITextView *outputTextView;
@property (nonatomic) NSMutableArray *context;
@end

@implementation AI_NL_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [@[] mutableCopy];
    [self.view addSubview:self.runButton];
    [self.view addSubview:self.clearButton];
    [self.clearButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.height.equalTo(@40);
        make.width.equalTo(self.runButton.mas_width);
    }];
    [self.runButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clearButton.mas_right).offset(10);
        make.right.equalTo(self.view);
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
    self.context = [NSMutableArray array];
    NSString *str = self.inputTextView.text;
    
    NSString *language_type = [self ai_for_languageTypeWithString:str];
    [self.context addObject:language_type];
    [self.context addObjectsFromArray:[self ai_analyse_string:str]];
    
    [self loadingHide];
    [self endCheckWithContext:[self.context copy]];
}

- (void)clearContext:(UIButton *)sender {
    self.inputTextView.text = @"";
}

- (NSString *)ai_for_languageTypeWithString:(NSString *)str {
    NSString *languageType = [NLLanguageRecognizer dominantLanguageForString:str];
    return SF(@"当前文本语言是:%@\n", languageType);
}
- (NSArray *)ai_analyse_string:(NSString *)str {
    self.tagger = [[NLTagger alloc] initWithTagSchemes:@[
        NLTagSchemeTokenType,
        NLTagSchemeLexicalClass,
        NLTagSchemeNameType,
        NLTagSchemeNameTypeOrLexicalClass,
        NLTagSchemeLemma,
        NLTagSchemeLanguage,
        NLTagSchemeScript,
//        NLTagSchemeSentimentScore >=iOS13
    ]];
    NSMutableArray *c = [NSMutableArray array];
    self.tagger.string = str;
    NSRange range = NSMakeRange(0, str.length);
    [self.tagger enumerateTagsInRange:range
                                 unit:NLTokenUnitWord
                               scheme:NLTagSchemeNameTypeOrLexicalClass
                              options:NLTaggerJoinNames
                           usingBlock:^(NLTag  _Nullable tag, NSRange tokenRange, BOOL * _Nonnull stop) {
        if([NLTagPersonalName isEqualToString:tag]) {
            NSString *t = SF(@"[人物名：%@]", [str substringWithRange:tokenRange]);
            if(![c containsObject:t]) {
                [c addObject:t];
            }
        }else if([NLTagPlaceName isEqualToString:tag]){
            NSString *t = SF(@"[地点名：%@]", [str substringWithRange:tokenRange]);
            if(![c containsObject:t]) {
                [c addObject:t];
            }
        }else if([NLTagOrganizationName isEqualToString:tag]) {
            NSString *t = SF(@"[组织名：%@]", [str substringWithRange:tokenRange]);
            if(![c containsObject:t]) {
                [c addObject:t];
            }
        }
        else {
            NSString *t = SF(@"[%@：%@]", tag, [str substringWithRange:tokenRange]);
            [c addObject:t];
        }
    }];
    return [c copy];
}

- (void)endCheckWithContext:(NSArray *)arr {
    self.outputTextView.text = [arr componentsJoinedByString:@"\n"];
}

- (NLLanguageRecognizer *)recognizer {
    if(!_recognizer) {
        _recognizer = [[NLLanguageRecognizer alloc] init];
    }
    return _recognizer;
}
- (NSString *)stringWithArticle {
    return @"新华社北京5月26日电:近日，国家主席习近平复信阿联酋中文教学“百校项目”学生代表，勉励他们学好中文、了解中国，为促进中阿友好贡献力量。习近平表示，我读了你们每个人的信，从字里行间、画里画外感受到了大家对中国文化的热爱，对两国友好的期盼。5年前，我同穆罕默德总统共同启动阿联酋中文教学“百校项目”，如今看到“学中文”在阿联酋已经成为一种新风尚，培养了一批像你们这样的中阿交流小使者，我很欣慰。习近平指出，你们在信中说，中国和阿联酋“手拉手”40年了，希望中阿永远是好朋友，中国人民也抱有同样的愿望。青少年代表着中阿友好关系的未来。欢迎你们来中国看熊猫、登长城，长大后到中国读大学，也欢迎更多的阿联酋青少年学习中文、了解中国，同中国的青少年交流交心、互学互鉴，把友谊的种子根植在心里，为开创中阿关系更加美好的明天贡献力量。2019年7月，在习近平主席和时任阿联酋阿布扎比王储穆罕默德共同见证下，中阿双方在北京签署备忘录，正式启动阿联酋中文教学“百校项目”。截至目前，阿联酋已有171所学校开设中文课程，7.1万名学生学习中文。近日，阿联酋“百校项目”示范校哈姆丹学校和亚斯学校40名中小学生代表分别用中文致信习主席，表达对中国文化的向往和热爱，立志做中阿友好的使者。";
}
- (UIButton *)runButton {
    if(!_runButton) {
        _runButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_runButton setTitle:@"分析" forState:UIControlStateNormal];
        [_runButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_runButton addTarget:self action:@selector(startRun:) forControlEvents:UIControlEventTouchUpInside];
        _runButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _runButton.titleLabel.textColor = [UIColor blackColor];
    }
    return _runButton;
}
- (UIButton *)clearButton {
    if(!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearContext:) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _clearButton.titleLabel.textColor = [UIColor blackColor];
    }
    return _clearButton;
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
