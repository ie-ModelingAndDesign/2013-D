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
    
    resultString= resultString * Rpoint;
    
    NSLog(@"%d",resultString);
    
    self.result_label.text= [[NSNumber numberWithUnsignedInt:resultString] stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
