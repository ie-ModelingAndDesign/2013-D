//
//  GameViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

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
    [self.Input becomeFirstResponder];
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
    
    
    
    // CSVファイルからセクションデータを取得する
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    NSScanner *scanner = [NSScanner scannerWithString:csv];
    
    // 改行文字の集合を取得
    NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet];
    // 一行ずつの読み込み
    NSString *line;
//    NSMutableArray *sections = [[NSMutableArray alloc] init];
    while (![scanner isAtEnd]) {
        // 一行読み込み
        [scanner scanUpToCharactersFromSet:chSet intoString:&line];
        NSLog(@"line = %@", line);
        // カンマ「,」で区切る
//        NSArray *array = [line componentsSeparatedByString:@","];
        // 配列に挿入する
//        [sections addObject:array];
        //　改行文字をスキップ
        [scanner scanCharactersFromSet:chSet intoString:NULL];
    }
    
    self.Example.text = (@"%@",line);

}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
