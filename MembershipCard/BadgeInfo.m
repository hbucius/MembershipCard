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
-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *)backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage withBadgeImage:(NSString*)badgeImage WithCardNumber:(NSString*) cardNumber withCardNumberLocation:(NSLocation*)cardNumberLocation withCardNmame:(NSString*) cardName WithCardNameLocation:(NSLocation*) cardNameLocation{
    self=[super init];
    if(self!=nil){
        self.badgeName=badgeName;
        self.badgeBackgroundColor=backgroundColor;
        self.badgeThumbImage=badgeThumbImage;
        self.badgeImage=badgeImage;
        self.cardNumber=cardNumber;
        self.cardNumberlocation=cardNumberLocation;
        self.cardName=cardName;
        self.cardNameLocation=cardNameLocation;
    }
    return self;
}


-(NSString *) defaultBadgeThumbImage{
    NSLog(@"get into defaultBadgeThumbImageURL");
    
    return  @"2.JPG" ;
    
}

@end
