//
//  BadgeInfos.h
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BadgeInfo.h"
@interface BadgeInfos : NSObject

@property(strong ,nonatomic) NSMutableArray *badges;

-(void ) addBadge:(BadgeInfo *) badge ;
-(void)  deleteBadgeWithName:(NSString *) label;
-(BadgeInfo *) getRadomBadge;
-(NSInteger) badgesCount;
-(BadgeInfo *) badgeAtIndex:(NSInteger) index;


+(BadgeInfos *) shareInstance;

@end
