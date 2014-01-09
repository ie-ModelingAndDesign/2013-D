//
//  TimerViewController.m
//  myFlick
//
//  Created by Ikei on 2013/12/30.
//  Copyright (c) 2013年 Ryunosuke Ikei. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
{
    float time; // time .. 時間の値
    NSTimer *countdown_timer;
    NSString *str; // str .. ラベルに表示する文字
}
// タイムを表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
// 中断ボタンとアクション接続するメソッド
- (IBAction)alertButton:(id)sender;

@end

@implementation TimerViewController

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
    // タイマー作成
    countdown_timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                       target:self
                                                     selector:@selector(update)
                                                     userInfo:nil
                                                      repeats:YES];
    time = 10.00; // 10.00からカウントダウン
    str = [NSString stringWithFormat:@"%.2f",time];
    _timerLabel.text = str;
    [countdown_timer fire]; // タイマースタート
}

// countdown_timerのセレクタで呼び出すメソッド
- (void)update
{
    if (time <= 0.00) {
        [countdown_timer invalidate]; // タイマー停止
        _timerLabel.text = @"0.0";
    }
    else {
        time -= 0.01;
        str = [NSString stringWithFormat:@"%.2f",time];
        _timerLabel.text = str;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 中断ボタンのタップで実行するメソッド
- (IBAction)alertButton:(id)sender {
    [countdown_timer invalidate]; // タイマー停止
    // アラート作成
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"中断"
                                                    message:@"やめますか?"
                                                   delegate:self
                                          cancelButtonTitle:@"キャンセル"
                                          otherButtonTitles:@"OK",nil];
    [alert show]; // アラートを表示する
}

// アラートのボタンがタップされた場合の処理(デリゲートメソッド)
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        // キャンセルボタン
        //NSLog(@"キャンセルされました");
        // 再度タイマーのインスタンスを作る
        countdown_timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                           target:self
                                                         selector:@selector(update)
                                                         userInfo:nil
                                                          repeats:YES];
        [countdown_timer fire]; // タイマースタート
    } else if (buttonIndex == 1){
        // OKボタン
        //NSLog(@"OKを選択しました");
        // 画面を戻すための処理
        // デリゲート先にtimerViewControllerDidFinishメソッドの処理を頼む
        [self.delegate timerViewControllerDidFinish:self];
    }
}

@end
