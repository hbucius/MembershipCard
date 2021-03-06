//
//  BadgeInfos.h
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Badge+Info.h"
@interface BadgeInfos : NSObject

@property(strong ,nonatomic) NSMutableArray *badges;
@property(weak,nonatomic) NSManagedObjectContext *context;
-(void ) addBadge:(Badge *) badge;
-(void)  deleteBadgeWithName:(NSString *) name;
-(Badge *) getRadomBadge;
-(NSInteger) badgesCount;
-(Badge *) badgeAtIndex:(NSInteger) index;
 
+(BadgeInfos *) shareInstance;

@end
