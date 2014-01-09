//
//  TimerViewController.h
//  myFlick
//
//  Created by Ikei on 2013/12/30.
//  Copyright (c) 2013年 Ryunosuke Ikei. All rights reserved.
//

#import <UIKit/UIKit.h>

// TimerViewControllerクラスをデリゲート阮元で使えるようにする
@class TimerViewController;

// プロトコルとデリゲートメソッドを宣言する
@protocol TimerViewControllerDelegate
- (void)timerViewControllerDidFinish:(TimerViewController *)controller;
@end

// UIAlertViewクラスのデリゲートプロトコルUIAlertViewDelegateを採用する
@interface TimerViewController : UIViewController <UIAlertViewDelegate>
// delegateプロパティの宣言
@property (weak, nonatomic) id <TimerViewControllerDelegate> delegate;

@end
