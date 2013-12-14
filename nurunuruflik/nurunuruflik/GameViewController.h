//
//  GameViewController.h
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/05.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *GTime;
@property (weak, nonatomic) IBOutlet UILabel *Result;
@property (weak, nonatomic) IBOutlet UILabel *Example;
@property (weak, nonatomic) IBOutlet UITextField *Input;



- (IBAction)Exit:(id)sender;
- (IBAction)Start:(id)sender;

-(void)onTimer:(NSTimer*)timer;

@end
