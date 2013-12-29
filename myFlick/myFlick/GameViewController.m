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
    // インスタンス変数宣言
    // sections .. csvFileから1行ずつ読み込んで配列にする.
    NSMutableArray *sections;
    // counter .. sectionsの添字として使う.
    NSInteger counter;
}
// 問題を表示するテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
// 文字を入力するテキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *inputText;
// 入力の状態を常に表示させておくテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *statementLabel;

// 文字が入力されると実行するメソッド
- (IBAction)checkCompare:(id)sender;
// やめるボタンとアクション接続するメソッド
- (IBAction)tapButton:(id)sender;
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

    //キーボードをデフォルト表示します.
    [_inputText becomeFirstResponder];
    
    // counterを1で初期化します.
    counter = 1;
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

// 常にチェックするメソッド
- (IBAction)checkCompare:(id)sender{
    // 問題の文字と入力した文字を比較します
    if ([_textLabel.text isEqualToString:_inputText.text]) {
        // 正解していた場合に, counterがsectionsの要素数を超えていたら, 終了です.
        if (counter >= sections.count) {
            _statementLabel.text = @"終了！";
            _inputText.enabled = NO; // 入力不可になります
        } else {
            _textLabel.text = sections[counter]; // counterは1からです.
            counter++;
        }
    } else {
        _statementLabel.text = @"続けて入力しよう";
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// やめるボタンのタップで実行するメソッド
- (IBAction)tapButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"選んで下さい"
                                                    message:@"ご予約は?"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"Aコース",@"Bコース",@"Cコース",nil];
    [alert show]; // アラートを表示する
}

// アラートのボタンがタップされた場合の処理(デリゲートメソッド）
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // キャンセルボタンの処理
    }else if(buttonIndex == 1){
        // OKボタンの処理
    }
}

@end
