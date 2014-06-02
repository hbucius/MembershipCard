//
//  ShareDriver.m
//  MembershipCard
//
//  Created by mstr on 6/3/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "ShareDriver.h"
static ShareDriver *_shareInstances;

@implementation ShareDriver



+(ShareDriver *) shareInstances{
    if(_shareInstances==nil){
        _shareInstances=[[ShareDriver alloc]init];
    }
    return _shareInstances;
}



@end
