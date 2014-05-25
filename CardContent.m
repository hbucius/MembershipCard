//
//  CardContent.m
//  MembershipCard
//
//  Created by mstr on 5/22/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "CardContent.h"

@implementation CardContent


-(id) initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if(self) {
        _contentInGroup=[aDecoder decodeObjectForKey:@"contentInGroup"];
    }
    NSLog(@"decode cardContent is finished");
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.contentInGroup forKey:@"contentInGroup"];
     NSLog(@"encode cardContent is finished.");
    
}

@end
