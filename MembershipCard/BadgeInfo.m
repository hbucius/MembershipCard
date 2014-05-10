//
//  BadgeInfo.m
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "BadgeInfo.h"



@implementation BadgeInfo

-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor
{
    self=[super init];
    if(self!=nil){
        self.badgeName=badgeName;
        self.badgeBackgroundColor=backgroundColor;
        self.badgeThumbImage=[self defaultBadgeThumbImage];

    }
    return self;
}

-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage{
    self=[super init];
    if(self!=nil){
        self.badgeName=badgeName;
        self.badgeBackgroundColor=backgroundColor;
        self.badgeThumbImage=badgeThumbImage;
    }
    return self;
}

-(NSString *) defaultBadgeThumbImage{
    NSLog(@"get into defaultBadgeThumbImageURL");
    
    return  @"2.JPG" ;
    
}

@end
