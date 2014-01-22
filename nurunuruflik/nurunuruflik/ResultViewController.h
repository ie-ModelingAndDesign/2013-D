//
//  ResultViewController.h
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 1/14/14.
//  Copyright (c) 2014 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController{
    int resultString;
    int Rpoint;
}

@property NSInteger *resultString;
@property NSInteger *Rpoint;
@property (weak, nonatomic) IBOutlet UILabel *result_label;

@end
