//
//  ShareDriver.h
//  MembershipCard
//
//  Created by mstr on 6/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyPageViewController.h"

@interface ShareDriver : NSObject
+(ShareDriver *) shareInstances;
@property MyPageViewController *myPageViewcontroller;
@end
