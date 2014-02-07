//
//  ResultViewController.h
//  nurunuruflik
//
//  Created by Hiroki MATSUMOTO on 1/14/14.
//  Copyright (c) 2014 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property int resultString;
@property (weak, nonatomic) IBOutlet UILabel *result_label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *vl;
@property BOOL easyvalue;
@property BOOL normalvalue;
@property BOOL hardvalue;

@end
