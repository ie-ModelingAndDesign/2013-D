//
//  GameViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import "GameViewController.h"

// TIME .. タイマーの初期値
#define TIME 60.00

@interface GameViewController ()
{
    NSMutableArray *sections; // csvFileから1行ずつ読み込んで配列にする.
    NSInteger counter; // sectionsの添字として使う.
}

// 文字が入力されると実行するメソッド
- (IBAction)checkCompare:(id)sender;
// csvファイルを読み込んで, クイズリストを作るメソッド.
- (void)fileLoadAndMakeQuizList;

@end

@implementation GameViewController

@synthesize GTime;
@synthesize Result;
@synthesize Example;
@synthesize Input;

// start_date .. タイマーの値
float start_date;
BOOL timeflg=FALSE;

NSTimer *timer;

- (void)onTimer:(NSTimer*)timer {
    if(timeflg == TRUE && start_date > 0.00){
        start_date -= 0.01;
        self.GTime.text = [NSString stringWithFormat:@"%.2f",start_date];
    }else if(start_date < 0.00){
        timeflg = FALSE;
        [timer invalidate]; // タイマー停止
        self.GTime.text = @"0.00";
        start_date = 0.00;
        self.Result.hidden = NO;
        self.Result.text = @"タイムアップ";
        //Input.enabled = NO;
    }else if(start_date == 0.00){
        timer = nil;
        start_date = TIME;
    }else if(start_date <= TIME && start_date > 0.00){
        timer = nil;
        start_date = TIME;
        self.Input.text = NULL;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // キーボードをデフォルト表示します.
    [self.Input becomeFirstResponder];
    
    // クイズリストを作成して, 1問目を表示します.
    [self fileLoadAndMakeQuizList];
    
    self.GTime.text = [NSString stringWithFormat:@"%.2f",TIME];
    self.Result.hidden = YES;
    // タイマーの設定
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(onTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
    // counterを0で初期化します.
    counter = 0;
}

// GameViewController表示時
-(void)viewWillAppear:(BOOL)animated{
    // navigation bar非表示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // タイマー初期化
    start_date = TIME;
    // goodAnswersは0からスタート
    goodAnswers = 0;
}

// GameViewControllerから遷移時
-(void)viewWillDisappear:(BOOL)animated{
    // navigation bar非表示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

// csvファイルを読み込んで, クイズリストを作るメソッド
- (void)fileLoadAndMakeQuizList
{
    // CSVファイルからセクションデータを取得する
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"todouhuken" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    NSScanner *scanner = [NSScanner scannerWithString:csv];
    
    NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet]; // chSet .. 改行文字の集合
    NSString *line; // line .. 1行ずつ読み込む
    sections = [[NSMutableArray alloc] init];
    
    // titleUse .. タイトル行読み飛ばしフラグ.
    // true .. 読み込む / false .. 飛ばす
    BOOL titleUse = true;
    // csvFileを最後まで読み込み, sectionsを完成させます.
    while (![scanner isAtEnd]) {
        // lineに1行読み込む
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
    self.Example.text = sections[0];
}

-(void)viewDidUnload{
    [self setExample:nil];
    [self setGTime:nil];
    [self setInput:nil];
    [self setResult:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)Start:(id)sender {
    self.Result.hidden = YES;
    if (timeflg == FALSE){
        timeflg = TRUE;
    }
}

// 入力した文字を常にチェックするメソッド. 1文字でも入力されたら実行されます.
- (IBAction)checkCompare:(id)sender{
    // 文字確定
    //[self.Input resignFirstResponder];
    //[self.Input becomeFirstResponder];
    if ([self.Example.text isEqualToString:self.Input.text]) {
        if (counter > sections.count) {
            self.Input.enabled = NO;
        } else {
            // 次の文字列を表示する. counterは0からです.
            self.Example.text = sections[counter + 1];
            // 文字をクリア
            [self.Input resignFirstResponder];
            self.Input.text = @"";
            [self.Input becomeFirstResponder];
            goodAnswers++; // 正解数を1増やします.
            counter++;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ボタンのタップで実行するメソッド
- (IBAction)alertButton:(id)sender{
    // タイマーを止める
    [timer invalidate];
    // アラートを作る
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"中断"
                                                    message:@"タイトルに戻りますか?"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"はい",nil];
    [alert show]; // アラートを表示する
}

// アラートのボタンがタップされた場合の処理(デリゲートメソッド)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        // キャンセルボタン
        //NSLog(@"キャンセルされました");
        // 再度タイマーのインスタンスを作る
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                 target:self
                                               selector:@selector(onTimer:)
                                               userInfo:nil
                                                repeats:YES];
        [timer fire]; // タイマースタート
    } else if (buttonIndex == 1){
        // OKボタン(タイトル画面へ遷移)
        //NSLog(@"OKを選択しました");
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

@end
