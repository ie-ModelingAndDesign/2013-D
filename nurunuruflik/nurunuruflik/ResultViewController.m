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
@synthesize value;
@synthesize resultString;
@synthesize easyvalue;
@synthesize normalvalue;
@synthesize hardvalue;


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
        NSLog(@"yes");
        if (resultString >= 0 && resultString < 100){
            NSLog(@"ok");
            self.value.text = @"残念!!もう一度頑張って(´；ω；｀)";
        }else{
            NSLog(@"ng");
            self.value.text = @"よく頑張りました( ´∀｀)b!";
        }
    }else if (normalvalue == YES){
        NSLog(@"yes");
        if (resultString >= 0 && resultString < 150){
            self.value.text = @"残念!!もう一度頑張って(´；ω；｀)";
        }else{
            self.value.text = @"よく頑張りました( ´∀｀)b!";
        }
    }else if (hardvalue == YES){
        NSLog(@"yes");
        if (resultString >= 0 && resultString < 300){
            self.value.text = @"残念!!もう一度頑張って(´；ω；｀)";
        }else{
            self.value.text = @"よく頑張りました( ´∀｀)b!";
        }
    }
    
    self.result_label.text = [[NSString alloc] initWithFormat:@"%d!", resultString];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
