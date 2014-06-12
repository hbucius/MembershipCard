//
//  BadgeInfos.m
//  MembershipCard
//
//  Created by mstr on 5/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "BadgeInfos.h"
#import "Constants.h"
#import "DataController.h"
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

-(void ) addBadge:(Badge *) badge{
    if([badge isKindOfClass:[Badge class]]){
      [self.badges addObject:badge];
    }
    
}
-(void)  deleteBadgeWithName:(NSString *) name{
    
    
}

-(NSInteger) badgesCount{
    return [self.badges count];
}

#pragma mark properties


-(NSMutableArray *) badges{
    if (_badges==nil) {
        //put the NSManagedObject to the array
        NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Badge" inManagedObjectContext:self.context];
        NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
        [fetchRequest setEntity:entityDescription];
        NSError *erro;
        NSArray *array=[self.context executeFetchRequest:fetchRequest error:&erro];
        NSLog(@"badges: the nubmer of badges is %d" ,array.count);
        if (array==nil) {
            NSLog(@"badges are  nil from database");
        }
        else {
            NSLog(@"badges are not nil from database");
            _badges=[[NSMutableArray alloc] initWithArray:array];
        }
        
    }
    return _badges;
}

-(NSManagedObjectContext *) context {
    if(_context==nil) {
        _context=[DataController shareInstance].context;
        NSLog(@"_context is get for the first time");
    }
    return  _context;
}

# pragma mark init
-(instancetype) initRandomBadges{
    self=[super init];
    if(self)
    {
        NSArray *badgesNames=@[@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅(知春路店)",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1",@"庆丰包子2",@"庆丰包子3",@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅(知春路店)",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1",@"庆丰包子2",@"庆丰包子3"];
       // NSArray *badgesNames=@[@"李宁",@"嘉和一品",@"老驴头",@"海底捞", @"乔丹",@"乙醇",@"麻辣香锅",@"老北京炸酱面",@"城隍庙小吃",@"樊家",@"庆丰包子1"];
         NSArray *randomColors=@[[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor]];
           for(NSString *badgeName in badgesNames){
             UIColor *color=randomColors[arc4random()%randomColors.count];      
               [Badge initWithName:badgeName WithbackgroundColor:color withBadgeThumbImage:DefaultThumbImage withBadgeImage:DefaultBadgeImage WithCardNumber:DefaultCardNumber withCardNumberLocation:[NSLocation right] withCardNmame:badgeName WithCardNameLocation:[NSLocation left] withCardContent:nil withContext:self.context];
       }
    }
    
    NSLog(@"initRandomBadge finished");
    return self;
    
}



-(Badge *) badgeAtIndex:(NSInteger) index{
    if(index<[self badgesCount]){
        return self.badges[index];
    }
    return nil;
}

-(void) deleteBadgeAtIndex:(NSUInteger) oldLocation reAddBadgeAtIndex:(NSUInteger) newLocation{
    Badge *badge=[self.badges objectAtIndex:oldLocation];
    [self.badges removeObjectAtIndex:oldLocation];
    [self.badges insertObject:badge atIndex:newLocation];
    
}


@end
