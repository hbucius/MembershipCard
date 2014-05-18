//
//  DataController.h
//  MembershipCard
//
//  Created by mstr on 5/17/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject
+ (DataController*) shareInstance ;

@property (strong,nonatomic)NSManagedObjectContext * context;
@end
