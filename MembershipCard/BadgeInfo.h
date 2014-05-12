//
//  BadgeInfo.h
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "NSLocation.h"
@interface BadgeInfo : NSObject
//used in collection view
@property(strong,nonatomic) NSString *badgeName;
@property(strong,nonatomic) NSString *badgeThumbImage;

//used in cardView
@property(strong,nonatomic) UIColor *badgeBackgroundColor;
@property(strong,nonatomic) NSString *badgeImage;
@property(strong,nonatomic) NSString *cardNumber ;
@property(strong,nonatomic) NSLocation *cardNumberlocation;
@property(strong,nonatomic) NSString *cardName;
@property(strong,nonatomic) NSLocation *cardNameLocation;
@property(strong,nonatomic) UIColor * cardNameColor;
@property(strong,nonatomic) UIColor * cardNumberColor;


-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor;
-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withBadgeThumbImage:(NSString*)badgeImage;
-(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *)backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage withBadgeImage:(NSString*)badgeImage WithCardNumber:(NSString*) cardNumber withCardNumberLocation:(NSLocation*)cardNumberLocation withCardNmame:(NSString*) cardName WithCardNameLocation:(NSLocation*) cardNameLocation;

@end
