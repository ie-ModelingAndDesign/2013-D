//
//  GameViewController.h
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate>
{
    NSInteger goodAnswers; // 正解数
}

@property (weak, nonatomic) IBOutlet UILabel *GTime;
@property (weak, nonatomic) IBOutlet UILabel *Result;
@property (weak, nonatomic) IBOutlet UILabel *Example;
@property (weak, nonatomic) IBOutlet UITextField *Input;
@property NSString *csvFile;


- (IBAction)Exit:(id)sender;
- (IBAction)Start:(id)sender;
// 中断ボタンとアクション接続するメソッド
- (IBAction)alertButton:(id)sender;

-(void)onTimer:(NSTimer*)timer;

@end
