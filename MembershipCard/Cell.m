//
//  Cell.m
//  MembershipCard
//
//  Created by mstr on 4/28/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CALayer *btnLayer=[self.CellImage layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:10.0f];
    [self.CellImage setBackgroundColor:[UIColor redColor]];
    
}

@end
