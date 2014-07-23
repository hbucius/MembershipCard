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

@property (nonatomic,strong) NSMutableArray *shouldHidden;

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
        NSArray *badgesNames=@[@"必胜客",@"拿渡",@"adidas",@"麦当劳",@"大嘴猴",@"星巴客",@"味千拉面",@"优衣库",@"宜家",@"Lee",@"汉堡王",@"一品三笑",@"KFC",@"小肥羊",@"乐扣",@"Kappa",@"相宜本草",@"Nike",@"必胜客",@"拿渡",@"adidas",@"麦当劳",@"大嘴猴",@"星巴客",@"味千拉面",@"优衣库"];
        NSArray *imagePath=@[@"必胜客.jpg",@"nadu.jpg",@"阿迪.jpg",@"MC.jpg",@"dazuihou .jpg",@"星巴克.jpg",@"味千.jpg",@"uniqlo.png",@"yijia.jpg",@"Lee.jpg",@"汉堡王.jpg",@"一品三笑.jpg",@"kfc.jpg",@"xiaofeiyang.jpg",@"KEKOU.jpg",@"kapa.jpg",@"xiangyibencao.jpg",@"Nike.jpg"];
        NSArray *randomColors=@[[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor purpleColor]];
        for(int i=0;i<badgesNames.count;i++){
            NSString *badgeName=[badgesNames objectAtIndex:i];
            NSString *ThumbImage=[imagePath objectAtIndex:i%imagePath.count];
            UIColor *color=randomColors[arc4random()%randomColors.count];
               [Badge initWithName:badgeName WithbackgroundColor:color withBadgeThumbImage:ThumbImage withBadgeImage:DefaultBadgeImage WithCardNumber:DefaultCardNumber withCardNumberLocation:[NSLocation right] withCardNmame:badgeName WithCardNameLocation:[NSLocation left] withCardContent:nil withContext:self.context];
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


-(void) invalidateBadgeAtIndex:(NSUInteger) index {
    
    [self.badges removeObjectAtIndex:index];

}

@end
