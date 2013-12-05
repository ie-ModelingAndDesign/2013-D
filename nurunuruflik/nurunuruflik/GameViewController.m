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

NSDate *start_date;
BOOL timeflg=FALSE;

NSTimer *timer;


- (void)onTimer:(NSTimer*)timer {
    if(timeflg){
        NSDate *now = [NSDate date];
        self.GTime.text = [NSString stringWithFormat:@"%.2f",
                              [now timeIntervalSinceDate:start_date]];
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
    self.GTime.text = @"0.00";
    self.Example.text = @"スタート";
    self.Result.hidden = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.01)
                                             target:self selector:@selector(onTimer:)
                                           userInfo:nil repeats:YES];
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
    } else {
        // 入力ミス
        //　タイマーを止めない。
        self.Result.hidden = NO;
        self.Result.text = @"ミス！";
    }
    
}

- (IBAction)Start:(id)sender {
    self.Result.hidden = YES;
    if (!timeflg){
        start_date = [NSDate date];
        timeflg = TRUE;
    }
    
    self.Example.text = @"aaa";

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
