//
//  BadgeInfo.h
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface BadgeInfo : NSObject
@property(strong,nonatomic) NSString *badgeName;
@property(strong,nonatomic) UIColor *badgeBackgroundColor;
@property(strong,nonatomic) NSString *badgeThumbImage;
-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor;
-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withBadgeThumbImage:(NSString*)badge;

@end
