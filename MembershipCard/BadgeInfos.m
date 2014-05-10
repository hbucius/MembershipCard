//
//  BadgeInfos.m
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "BadgeInfos.h"


@interface BadgeInfos()


@end

@implementation BadgeInfos

#pragma mark singleton;

static BadgeInfos *sharedSingleton;
+(void) initialize{
    static BOOL initialized=NO;
    if(!initialized){
        NSLog(@"initialized=No");
        initialized=YES;
        sharedSingleton=[[BadgeInfos alloc]initRandomBadges];
    }
    
}
+(BadgeInfos *) shareInstance{
    return sharedSingleton;
}



# pragma mark operations in badge array

-(void ) addBadge:(BadgeInfo *) badge {
    if([badge isKindOfClass:[BadgeInfo class]])
        [self.badges addObject:badge];
}
-(void)  deleteBadgeWithName:(NSString *) label{
    
    
}

-(NSInteger) badgesCount{
    return [self.badges count];
}

#pragma mark properties


-(NSMutableArray *) badges{
    if (_badges==nil) {
        _badges=[[NSMutableArray alloc]init];
    }
    return _badges;
}


# pragma mark init
-(instancetype) initRandomBadges{
    self=[super init];
    if(self)
    {
        NSArray *badgesNames=@[@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅(知春路店)",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1",@"庆丰包子2",@"庆丰包子3",@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅(知春路店)",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1",@"庆丰包子2",@"庆丰包子3"];
    //    NSArray *badgesNames=@[@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1"];
        NSArray *randomColors=@[[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor]];
        for(NSString *badgeName in badgesNames){
            UIColor *color=randomColors[arc4random()%randomColors.count];
            [self addBadge:[[BadgeInfo alloc]initWithName:badgeName WithbackgroundColor:color withBadgeThumbImage:DefaultThumbImage]];
        }
    }
    
    NSLog(@"initRandomBadge finished");
    return self;
    
}

-(BadgeInfo *) getRadomBadge{
    if([self badgesCount]==0) return nil;
    int randomCount=arc4random()%self.badges.count;
    BadgeInfo *badge= self.badges[randomCount];
    [self.badges removeObjectAtIndex:randomCount];
    return badge;
}

-(BadgeInfo *) badgeAtIndex:(NSInteger) index{
    if(index<[self badgesCount]){
        return self.badges[index];
    }
    return nil;
}

@end
