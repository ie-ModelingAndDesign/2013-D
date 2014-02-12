//
//  ViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 2013/12/01.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // navigation barを隠す
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
 // _view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender{
    
}

@end
