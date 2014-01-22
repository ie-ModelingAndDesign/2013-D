//
//  GameViewController.h
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>
//{
  //  NSInteger goodAnswers; // 正解数
//}

@property (weak, nonatomic) IBOutlet UILabel *GTime;
@property (weak, nonatomic) IBOutlet UILabel *Result;
@property (weak, nonatomic) IBOutlet UILabel *Example;
@property (weak, nonatomic) IBOutlet UITextField *Input;
@property (weak, nonatomic) IBOutlet UILabel *statementLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerPoint;
@property NSString *csvFile;
@property NSInteger goodAnswers;
@property NSInteger Rpoint;

- (IBAction)Start:(id)sender;
-(void)onTimer:(NSTimer*)timer;

// 中断ボタンとアクション接続するメソッド
- (IBAction)alertButton:(id)sender;

@end
