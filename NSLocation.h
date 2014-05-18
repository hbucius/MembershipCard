//
//  NSLocation.h
//  MembershipCard
//
//  Created by mstr on 5/10/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocation : NSObject <NSCoding>

+(NSLocation *) right;
+(NSLocation *) left;

@property (nonatomic) BOOL simpleLayout;
-(BOOL) isEqual:(id)object ;

@end
