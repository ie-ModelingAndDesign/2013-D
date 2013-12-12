//
//  ViewController.m
//  myFlick
//
//  Created by Ryunosuke Ikei on 2013/12/12.
//  Copyright (c) 2013年 Ryunosuke Ikei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//入力する文字列を表示するテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
//自分で入力した文字列を表示するテキストフィールド
@property (weak, nonatomic) IBOutlet UITextField *enterText;
//結果を表示するテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
//入力した文字列のチェックを実行するメソッド
- (IBAction)checkButton:(UIButton *)sender;
//常に結果を表示させておくテキストフィールド
@property (weak, nonatomic) IBOutlet UILabel *resultLabelAlways;
//文字が入力されると実行するメソッド
- (IBAction)checkCompare:(id)sender;
//背景がタップされたら実行するメソッド
- (IBAction)bkgTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //キーボードをデフォルト表示する
    [_enterText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//表示の文字列と合っているかチェックする
- (IBAction)checkButton:(UIButton *)sender {
    NSString *ans;
    if ([_textLabel.text isEqualToString:_enterText.text]) {
        ans = @"正解！";
    } else {
        ans = @"やり直し！";
    }
    _resultLabel.text = ans;
}

//常にチェックするメソッド
- (IBAction)checkCompare:(id)sender{
    NSString *ans;
    if ([_textLabel.text isEqualToString:_enterText.text]) {
        ans = @"正解！";
    } else {
        ans = @"やり直し！";
    }
    _resultLabelAlways.text = ans;
}

//背景タップでキーボードを引っ込める
- (IBAction)bkgTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
