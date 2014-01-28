//
//  ResultViewController.m
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 1/14/14.
//  Copyright (c) 2014 Hiroki MATSUMOTO. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize result_label;
@synthesize resultString;


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
    
    
    NSLog(@"ポイントは%d",resultString);
    
    self.result_label.text = [[NSString alloc] initWithFormat:@"%d!", resultString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
