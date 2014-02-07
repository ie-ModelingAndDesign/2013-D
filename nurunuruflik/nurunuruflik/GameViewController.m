//
//  GameViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import "GameViewController.h"
#import "ResultViewController.h"

// タイマーの初期値
#define TIME 60.00

@interface GameViewController ()
{
    NSMutableArray *sections; // csvFileから1行ずつ読み込んで配列にする.
    NSInteger counter; // sectionsの添字として使う.
    
    NSInteger charNo; // 文字列用カウンター
    NSInteger strLength; // 回避用
    char ch; // 1文字保存用
    NSMutableString *text; // statementLabel回避用
    
    NSString *point; // 得点
}

// 文字が入力されると実行するメソッド
- (IBAction)editingChanged:(id)sender;
// csvファイルを読み込んで, クイズリストを作るメソッド.
- (void)fileLoadAndMakeQuizList;

@end

@implementation GameViewController

@synthesize GTime;
@synthesize Example;
@synthesize Input;
@synthesize csvFile;
@synthesize statementLabel;
@synthesize pointLabel;
@synthesize goodAnswers;
@synthesize Rpoint;

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
        NSLog(@"%d",goodAnswers);
        [self performSegueWithIdentifier:@"Result" sender:nil];
    }else if(start_date == 0.00){
        timer = nil;
        start_date = TIME;
    }else if(start_date <= TIME && start_date > 0.00){
        timer = nil;
        start_date = TIME;
        self.Input.text = NULL;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    goodAnswers=goodAnswers*Rpoint;
    
    if([[segue identifier] isEqualToString:@"Result"]){
        ResultViewController *RVC = [segue destinationViewController];
        RVC.resultString = goodAnswers;
        NSLog(@"load");
        if (Rpoint == 20){
            RVC.easyvalue = YES;
        }else if (Rpoint == 30){
            RVC.normalvalue = YES;
        }else if (Rpoint == 50){
            RVC.hardvalue = YES;
        }
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
    // show keyboard
    [self.Input becomeFirstResponder];
    self.Input.delegate = self;
    
    // counter, charNoを0で初期化します.
    counter = 0; charNo = 0; goodAnswers = 0;
    NSLog(@"charNo=%d", charNo);
    
    // キーボードをデフォルト表示します.
    [self.Input becomeFirstResponder];
    self.Input.delegate = self;
    
    // クイズリストを作成して, 1問目を表示します.
    [self fileLoadAndMakeQuizList];
    // 文字列の長さを取得し, chに1文字目を保存
    strLength = self.Example.text.length;
    ch = [self.Example.text characterAtIndex:charNo];
    
    self.GTime.text = [NSString stringWithFormat:@"%.2f",TIME];
    // タイマーの設定
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

// GameViewController表示時
-(void)viewWillAppear:(BOOL)animated{
    // navigation bar非表示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // タイマー初期化
    start_date = TIME;
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
    //csvFile = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"csv"];
    //NSLog(@"Load csv");
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
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)Start:(id)sender {
    if (timeflg == FALSE){
        timeflg = TRUE;
    }
}

// 文字列で比較ではなく、一文字ずつチェックして最後まできたら１問正解としたらどうか？
- (BOOL)textField:(UITextField *)Input shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)inputText
{
    //NSLog(@"inputText=%@", inputText);
    if (inputText.length == 0) {
        //NSLog(@"backspace");
        return YES;
    } else if (self.Input.text.length == 0 && [inputText characterAtIndex:0] == [self.Example.text characterAtIndex:charNo]) {
        // 1文字正解なら文字を確定する
        text = [self.statementLabel.text mutableCopy];
        [text appendString:inputText];
        self.statementLabel.text = text;
        // 最後の文字ならば
        if (charNo+1 == strLength) {
            // 最後の問題かをチェック
            if (sections.count <= counter+1) {
                [self performSegueWithIdentifier:@"Result" sender:nil];
            } else {
                // 次の文字列を表示する. counterは0からです.
                self.Example.text = sections[counter+1];
                counter++;
                goodAnswers++;
                point = [[NSString alloc] initWithFormat:@"%d",goodAnswers];
                self.pointLabel.text = point;
                charNo = 0;
                //NSLog(@"charNo=%d",charNo);
                strLength = self.Example.text.length;
                ch = [self.Example.text characterAtIndex:charNo];
                self.statementLabel.text = @""; // reset statementLabel
            }
        }else {
            // 次の文字を保存
            charNo++;
            ch = [self.Example.text characterAtIndex:charNo];
            //NSLog(@"charNo=%d",charNo);
        }
        return NO;
    }
    return YES;
}

// return YES
- (IBAction)editingChanged:(id)sender
{
    //NSLog(@"editingChanged");
    // 小文字,濁点,半濁点の判定
    if (self.Input.text.length != 0) {
        if (self.Input.text.length == 1 && [self.Input.text characterAtIndex:0] == [self.Example.text characterAtIndex:charNo]) {
            text = [self.statementLabel.text mutableCopy];
            [text appendString:self.Input.text];
            self.statementLabel.text = text;
            if (charNo+1 == strLength) {
                if (sections.count <= counter+1) {
                    [self performSegueWithIdentifier:@"Result" sender:nil];
                } else {
                    self.Example.text = sections[counter+1];
                    counter++;
                    goodAnswers++;
                    point = [[NSString alloc] initWithFormat:@"%d",goodAnswers];
                    self.pointLabel.text = point;
                    charNo = 0;
                    //NSLog(@"CharNo=%d",charNo);
                    strLength = self.Example.text.length;
                    ch = [self.Example.text characterAtIndex:charNo];
                    self.statementLabel.text = @""; // reset statementLabel
                }
            }else {
                charNo++;
                ch = [self.Example.text characterAtIndex:charNo];
                //NSLog(@"CharNo=%d", charNo);
            }
            // 文字列をクリア
            [self.Input resignFirstResponder];
            self.Input.text = @"";
            [self.Input becomeFirstResponder];
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
                                          otherButtonTitles:@"OK",nil];
    [alert show]; // アラートを表示する
}

// アラートのボタンがタップされた場合の処理(デリゲートメソッド)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"中断");
    if (buttonIndex == 0){
        // キャンセルボタン
        NSLog(@"キャンセルされました");
        // 再度タイマーのインスタンスを作る
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                 target:self
                                               selector:@selector(onTimer:)
                                               userInfo:nil
                                                repeats:YES];
        [timer fire]; // タイマースタート
    } else if (buttonIndex == 1){
        // OKボタン(タイトル画面へ遷移)
        NSLog(@"OKを選択しました");
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}


    
@end
