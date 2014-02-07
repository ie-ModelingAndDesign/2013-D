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
@synthesize vl;
@synthesize resultString;
@synthesize easyvalue;
@synthesize normalvalue;
@synthesize hardvalue;

NSString *ganbari = @"よく頑張りました( ´∀｀)b!";
NSString *zannen = @"残念!!もう一度頑張って(´；ω；｀)";


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
    
    if (easyvalue == YES){
        NSLog(@"eyes");
        if (resultString >= 0 && resultString < 100){
            NSLog(@"eng");
            vl.text = zannen;
        }else{
            NSLog(@"eok");
            vl.text = ganbari;
        }
    }else if (normalvalue == YES){
        NSLog(@"nyes");
        if (resultString >= 0 && resultString < 150){
            vl.text = zannen;
        }else{
            vl.text = ganbari;
        }
    }else if (hardvalue == YES){
        NSLog(@"nyes");
        if (resultString >= 0 && resultString < 300){
            vl.text = zannen;
        }else{
            vl.text = ganbari;
        }
    }
    //[self.view addSubview:vl];
    
    self.result_label.text = [[NSString alloc] initWithFormat:@"%d!", resultString];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
