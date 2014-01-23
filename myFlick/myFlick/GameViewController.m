//
//  GameViewController.m
//  myFlick
//
//  Created by Ryunosuke Ikei on 2013/12/12.
//  Copyright (c) 2013年 Ryunosuke Ikei. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
    NSMutableArray *sections; // sections .. csvFileから1行ずつ読み込んで配列にする.
    NSInteger counter; // sectionsの添字として使う.
    
    NSInteger charNo; // 文字列用カウンター
    NSInteger strLength; // 回避用
    char ch; // 1文字保存用
    NSMutableString *text; // statementLabel回避用
}
// 問題を表示するテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
// 文字を入力するテキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *inputField;
// 入力の状態を常に表示させておくテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *statementLabel;

- (IBAction)editingChanged:(id)sender;

// csvファイルを読み込んで, クイズリストを作るメソッド.
- (void)fileLoadAndMakeQuizList;
@end

@implementation GameViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // クイズリストを作成して, 1問目を表示します.
    [self fileLoadAndMakeQuizList];
    strLength = _textLabel.text.length;

    //キーボードをデフォルト表示します.
    [_inputField becomeFirstResponder];
    _inputField.delegate = self;
    
    // counter, charNoを0で初期化します.
    counter = 0; charNo = 0;
}

// csvファイルを読み込んで, クイズリストを作るメソッド
- (void)fileLoadAndMakeQuizList
{
    // CSVファイルからセクションデータを取得する
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"japan" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    NSScanner *scanner = [NSScanner scannerWithString:csv];
    
    NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet]; // chSet .. 改行文字の集合
    NSString *line; // line .. 1行ずつ読み込む
    sections = [[NSMutableArray alloc] init];
    
    // タイトル行読み飛ばしフラグ.
    // true .. 読み込む / false .. 飛ばす
    BOOL titleUse = true;
    // csvFileを最後まで読み込み, sectionsを完成させます.
    while (![scanner isAtEnd]) {
        // 1行読み込む
        [scanner scanUpToCharactersFromSet:chSet intoString:&line];
        if (titleUse) {
            // 配列に挿入します
            [sections addObject:line];
        }
        // 改行文字をスキップ
        [scanner scanCharactersFromSet:chSet intoString:NULL];
        titleUse = true;
    }
    // (titleUseがtrueのとき)sections[0] ~ sections[(csvFileの行数)-1]が完成しました.
    // Fisher-Yatesアルゴリズムを使ってsectionsの並び替えを行い, クイズリストを作ります.
    for (NSInteger i = sections.count-1; i >= 0; i--){
        NSInteger j = arc4random() % (i+1);
        [sections exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    // 1問目を表示します
    _textLabel.text = sections[0];
}

// 文字列で比較ではなく、一文字ずつチェックして最後まできたら１問正解としたらどうか？
- (BOOL)textField:(UITextField *)inputField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)inputText
{
    NSLog(@"inputText=%@", inputText);
    if (inputText.length == 0) {
        NSLog(@"backspace");
        return YES;
    } else if (_inputField.text.length == 0 && [inputText characterAtIndex:0] == [_textLabel.text characterAtIndex:charNo]) {
        // 1文字正解なら文字を確定する
        text = [self.statementLabel.text mutableCopy];
        [text appendString:inputText];
        self.statementLabel.text = text;
        // 最後の文字ならば
        if (charNo+1 == strLength) {
            // 最後の問題かをチェック
            if (sections.count <= counter+1) {
                _inputField.enabled = NO;
                _textLabel.text = @"Clear!";
            } else {
                // 次の文字列を表示する. counterは0からです.
                _textLabel.text = sections[counter+1];
                counter++;
                charNo = 0;
                NSLog(@"charNo=%d",charNo);
                strLength = _textLabel.text.length;
                ch = [_textLabel.text characterAtIndex:charNo];
                self.statementLabel.text = @""; // reset statementLabel
            }
        } else {
            // 次の文字を保存
            charNo++;
            ch = [_textLabel.text characterAtIndex:charNo];
            NSLog(@"charNo=%d",charNo);
        }
        return NO;
    }
    return YES;
}

// return YES
- (IBAction)editingChanged:(id)sender
{
    NSLog(@"editingChanged");
    // 小文字,濁点,半濁点の判定
    if (_inputField.text.length != 0) {
        if (_inputField.text.length == 1 && [_inputField.text characterAtIndex:0] == [_textLabel.text characterAtIndex:charNo]) {
            text = [_statementLabel.text mutableCopy];
            [text appendString:_inputField.text];
            self.statementLabel.text = text;
            if (charNo+1 == strLength) {
                if (sections.count <= counter+1) {
                    _inputField.enabled = NO;
                    _textLabel.text = @"Clear!";
                } else {
                    _textLabel.text = sections[counter+1];
                    counter++;
                    charNo = 0;
                    NSLog(@"CharNo=%d",charNo);
                    strLength = _textLabel.text.length;
                    ch = [_textLabel.text characterAtIndex:charNo];
                    self.statementLabel.text = @""; // reset statementLabel
                }
            } else {
                charNo++;
                ch = [_textLabel.text characterAtIndex:charNo];
                NSLog(@"CharNo=%d", charNo);
            }
            // 文字列をクリア
            [_inputField resignFirstResponder];
            _inputField.text = @"";
            [_inputField becomeFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
