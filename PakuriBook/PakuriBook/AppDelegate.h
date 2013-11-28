//
//  AppDelegate.h
//  PakuriBook
//
//  Created by Hiroki MATSUMOTO on 2013/11/17.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
Facebook *facebook;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ViewController;
@property (nonatomic, retain) Facebook *facebook;

@end
