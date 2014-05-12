//
//  NSLocation.m
//  MembershipCard
//
//  Created by mstr on 5/10/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "NSLocation.h"

@interface NSLocation ()
@property (strong,nonatomic) NSString *direction;  //left ,right,only this two is allowed right now
@end



@implementation NSLocation

+(NSLocation *)right{
    
    return [[NSLocation alloc]initWith:@"right"];
}

+(NSLocation *)left{
    return [[NSLocation alloc]initWith:@"left"];
}
-(instancetype) initWith:(NSString*) direction{
    self=[super init];
    if(self){
        self.direction=direction;
        self.simpleLayout=YES;
    }
    return self;
}
-(BOOL) isEqual:(id)object2 {
    if([object2 isKindOfClass:[NSString class]]){
        return [self.direction isEqualToString:object2];
    }
    else if([object2 isKindOfClass:[NSLocation class]])
     {
        return [self.direction isEqualToString:[(NSLocation*)object2 direction]];
    }
    else return false;
}




@end
