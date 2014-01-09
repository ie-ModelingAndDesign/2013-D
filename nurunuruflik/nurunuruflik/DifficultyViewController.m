//
//  DifficultyViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/08.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import "DifficultyViewController.h"

@implementation DifficultyViewController

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
}

// DifficultyViewController表示時
-(void)viewWillAppear:(BOOL)animated{
    // navigation bar表示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// DifficultyViewControllerから遷移時
-(void)viewWillDisappear:(BOOL)animated{
    // navigation bar非表示
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
