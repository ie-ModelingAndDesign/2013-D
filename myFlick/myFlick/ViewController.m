//
//  ViewController.m
//  myFlick
//
//  Created by Ikei on 2013/12/15.
//  Copyright (c) 2013年 Ryunosuke Ikei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TimerViewControllerクラスのデリゲートメソッド
- (void)timerViewControllerDidFinish:(TimerViewController *)controller
{
    // スタックしてあるビューコントローラに移動する(戻ってくる)
    [self dismissViewControllerAnimated:YES completion:nil];
}

// セグエで移動する直前に発生するイベント
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // セグエの識別子(identifier)ガshowAlternateならば
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        // 移動先のビューコントローラのデリゲート先にselfを設定する
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
