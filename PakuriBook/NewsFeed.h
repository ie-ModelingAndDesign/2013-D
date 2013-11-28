//
//  NewsFeed.h
//  PakuriBook
//
//  Created by Natumi KOUTI on 2013/11/24.
//  Copyright (c) 2013年 Hiroki MATSUMOTO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"


@interface MyGreatIOSAppAppDelegate : NSObject
<UIApplicationDelegate, FBSessionDelegate>

Facebook* facebook;

NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", @"offline_access",nil];
[facebook authorize:permissions delegate:self];

- (void)fbDidLogin {
	NSLog(@"login");
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

NSArray *permissions = [NSArray arrayWithObjects:@"user_about_me",
						@"publish_stream",nil];

[appDelegate.facebook authorize:permissions delegate:self];

@protocol NewsFeed <NSObject>

@end
