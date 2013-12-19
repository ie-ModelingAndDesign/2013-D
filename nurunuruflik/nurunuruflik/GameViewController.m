//
//  GameViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
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

float start_date = 60.00;
BOOL timeflg=FALSE;

NSTimer *timer;

- (void)onTimer:(NSTimer*)timer {
    if(timeflg == TRUE && start_date > 0.00){
        start_date -= 0.01;
        self.GTime.text = [NSString stringWithFormat:@"%.2f",start_date];
    }else if(start_date < 0.00){
        timeflg = FALSE;
        [timer invalidate];
        self.GTime.text = @"0.00";
        start_date = 0.00;
        self.Result.hidden = NO;
        self.Result.text = @"タイムアップ";
        Input.enabled = NO;
    }else if(start_date == 0.00){
        timer = nil;
        start_date = 60.00;
    }else if(start_date <= 60.00 && start_date > 0.00){
        timer = nil;
        start_date = 60.00;
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
    self.GTime.text = @"60.00";
    self.Example.text = @"スタート";
    self.Result.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
    // クイズリストを作成して, 1問目を表示します.
    [self fileLoadAndMakeQuizList];
    
    // counterを1で初期化します.
    counter = 1;
    
    //キーボードをデフォルト表示します.
    [self.Input becomeFirstResponder];
}

// csvファイルを読み込んで, クイズリストを作るメソッド
- (void)fileLoadAndMakeQuizList
{
    // CSVファイルからセクションデータを取得する
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"csv"];
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

//enter
- (IBAction)Exit:(id)sender {
    NSString *strExample = self.Example.text;
    NSString *strInput = self.Input.text;
    if ([strExample isEqualToString:strInput]) {
        // 例題と入力した文章が一致！
        timeflg = FALSE;
        self.Result.hidden = NO;
        self.Result.text = @"正解！";
    }else {
        // 入力ミス
        //　タイマーを止めない。
        self.Result.hidden = NO;
        self.Result.text = @"ミス！";
    }
}

- (IBAction)Start:(id)sender {
    self.Result.hidden = YES;
    if (timeflg == FALSE){
        timeflg = TRUE;
    }
}

// 入力した文字を常にチェックするメソッド. 1文字でも入力されたら実行されます.
- (IBAction)checkCompare:(id)sender{
    if ([self.Example.text isEqualToString:self.Input.text]) {
        if (counter >= sections.count) {
            self.Input.enabled = NO;
        } else {
            self.Example.text = sections[counter]; // counterは1からです.
            counter++;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
